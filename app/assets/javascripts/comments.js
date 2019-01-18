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
        <div class="profile-info">
          <p id="chef_comment_heading" class="center"><strong>Chefs' Comments:</strong></p><ul id="comment_list">
        `
        $('#see-recs').replaceWith(commentHeadingHtml)
        $('#comment_list').append(newComments)
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
         if ($(response).find('div.field_with_errors').length === 0) {
           if ($('#comment_list li').length > 0) {
             $('#comment_list').append(response) //append the new comment to existing list of comments
           } else {
             $('#comment_list').replaceWith(response) // replace "None!" with the new, valid comment
           }
           $('#comment_form').empty()
         } else { //if there are errors
            let inputErrorHtml = `
            <div class="field_with_errors"><input placeholder="is too short (minimum is 10 characters)" type="text" value="test" name="comment[content]" id="comment_content" /></div>
            `
            $('#comment_content').replaceWith(inputErrorHtml)
          }
        $('#comment_content').val("") //reset input to be blank
     }
     })
  })
}

// function Comment(comment) {
//   this.id = comment.id
//   this.content = comment.content
//   this.chef = comment.chef
//   this.restaurant = comment.restaurant
// }
//
// Comment.prototype.revealComments = function() {
//   let commentHtml = `
//       <li>
//       ${this.content} — <a href="/chefs/${this.chef.id}">${this.chef.name}</a></li>
//   `
//   return commentHtml
// }

//class syntax

class Comment {
  constructor(comment) {
    this.id = comment.id
    this.content = comment.content
    this.chef = comment.chef
    this.restaurant = comment.restaurant
  }
  revealComments() {
    let commentHtml = `
        <li>${this.content} — <a href="/chefs/${this.chef.id}">${this.chef.name}</a></li>
    `
    return commentHtml
  }
}
