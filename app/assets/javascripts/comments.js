$(() => {
  bindCommentClickListeners()
})

const bindCommentClickListeners = function() {
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
