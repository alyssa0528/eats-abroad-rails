$(() => {
  bindCommentClickListeners()
})

const bindCommentClickListeners = function() {
  //for "see recommendations" link
  $(document).on('click', '#see-recs', function(e) {
    e.preventDefault()
    let id = this.href
    fetch(`${id}.json`)
      .then(response => response.json())
      .then(data => {
        //let newRestaurant = new Restaurant(data);
        //debugger
        //let restaurantHtml = newRestaurant.revealComments();
        let newComments = data.map(function(comment) {
          //debugger
          new Comment(comment)
        })
        //console.log(newComments)
        let commentHtml = newComments.revealComments()
        //$('#see-recs').replaceWith(restaurantHtml)
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
  debugger
  let recHtml = `
  <p>Chefs' Comments:</p>
  <ul>
    ${this.comments.map((comment) => `
      <li>
      ${comment.content} — <a href="/chefs/${comment.chef.id}">${comment.chef.name}</a>
      </li>
    `
  ).join('')
}
  </ul>
  `
  debugger
  return recHtml
}
