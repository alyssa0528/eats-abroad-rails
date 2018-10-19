$(() => {
  bindCommentClickListeners()
})

const bindCommentClickListeners = () => {
  //for "see recommendations" link
  $(document).on('click', '#see-recs', function(e) {
    e.preventDefault()
    let id = this.pathname
    console.log(id)
    fetch(`${id}.json`)
      .then(response => response.json())
      .then(data => {
        let newComments = data.map(comment => new Comment(comment).revealComments())
        //console.log(newComments) //returns array of 3 Comment objects
        let commentHeadingHtml = `
          <p id="chef_comment_heading"><strong>Chefs' Comments:</strong></p><ul id="comment_list"></ul>
        `
        $('#see-recs').replaceWith(commentHeadingHtml)
        $('#comment_list').after(newComments)
      })
  })

//for comment form submission
  $('#comment_form').on('submit', function(e) {
    e.preventDefault();
    let action = $(this).attr('action') // "restaurants/:id/comments"
    let method = $(this).attr('method') // "post"
    let commentContent = $(this).find('#comment_content').val() // the comment
    let data = $(this).serializeArray() //array of utf8, auth token, and comment itself
    console.log(data)
    $.ajax({
       method: method,
       url: action,
       data: data,
       success: function(response) {
         $('#comment_list').append(response)
         $('#comment_content').val("")
       }
     })
  })
}

function Comment(comment) {
  this.id = comment.id
  this.content = comment.content
  this.chef = comment.chef
  this.restaurant = comment.restaurant
}

Comment.prototype.revealComments = function() {
  let commentHtml = `
      <li>
      ${this.content} — <a href="/chefs/${this.chef.id}">${this.chef.name}</a></li>
  `
  return commentHtml
}
