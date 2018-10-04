$(() => {
  bindClickListeners()
})

const bindClickListeners = function() {
  //for INDEX restaurants
  $('#all_restaurants').on('click', function(e) {
    e.preventDefault();
    //history.pushState(null, null, "restaurants") //updates URL, but is incorrect when link is clicked
    //from other pages...
    fetch('/restaurants.json')
      .then(response => response.json())
      .then(restaurants => {
        $('#body-container').html('')
        restaurants.forEach(function(restaurant) {
          let newRestaurant = new Restaurant(restaurant)
          let restaurantHtml = newRestaurant.formatIndex()
          $('#body-container').append(restaurantHtml)
        })
      })
    })
    //for SHOW restaurant
  $(document).on('click', '.show-link', function(e) {
    e.preventDefault();
    $('#body-container').html('')
    let id = $(this).attr("data-id")
    //history.pushState(null, null, `restaurants/${id}`) //incorrect when link is clicked from other page
    fetch(`/restaurants/${id}.json`)
      .then(response => response.json())
      .then(restaurant => {
        // append restaurant JSON object to the #body-container div
        let newRestaurant = new Restaurant(restaurant);
        //console.log(restaurant)
        let restaurantHtml = newRestaurant.formatShow();
        $('#body-container').append(restaurantHtml)
      })
    })
  //for EXISTING RESTAURANT form (the restaurant drop-down)
  // $('#add_existing').on('submit', function(e) { //#add_existing is the ID for the form
  //   e.preventDefault();
  //   //console.log($(this)) //'this' is the form itself
  //   let action = $(this).attr('action')
  //   let method = $(this).attr('method')
  //   let data = $(this).serializeArray()
  //   //console.log(data)
  //   $.ajax({
  //     method: method,
  //     url: action,
  //     data: data,
  //     dataType: 'script'
  //   })
  //   //post the data, then show the comment form
  //   //post the comment, and then take user to the restaurant's show page
  // })
}

//constructor function
function Restaurant(restaurant) { //reification (turning raw data and turning it into a JS object)
  this.id = restaurant.id
  this.name = restaurant.name
  this.cuisine = restaurant.cuisine
  this.city = restaurant.city
  this.comments = restaurant.comments
  this.chefs = restaurant.chefs
}

//to create Restaurant index page format
Restaurant.prototype.formatIndex = function() {
  let restaurantHtml = `
    <a href="/restaurants/${this.id}" class="show-link" data-id="${this.id}"><h1>${this.name}</h1></a>
    <p>${this.cuisine} | ${this.city.name}</p>
  `
  return restaurantHtml
}

//to create Restaurant show page format
Restaurant.prototype.formatShow = function() {
  let restaurantHtml = `
    <h1>${this.name}</h1>
    <p><strong>Cuisine:</strong> ${this.cuisine}</p>
    <p><strong>City:</strong> ${this.city.name}</p>
    <p><strong>Recommended by:</strong></p>
    <ul>
      ${this.chefs.map((chef) => `
        <li>
        <a href="/chefs/${chef.id}" class="chef_links">${chef.name}</a>
        </li>
        `
      ).join('')
    }
    </ul>

    <a href="/restaurants/${this.id}/comments" id="see-recs">See Recommendations</a>
    `
  return restaurantHtml
}

//to show Add Comment form after adding a restaurant
Restaurant.prototype.showCommentForm = function() {
  let commentFormHtml = `
  <h2>Enter a comment for ${this.name}:</h2>
  <form action="/restaurants/${this.id}/comments" method="post" accept-charset="UTF-8">
    <label>Your thoughts:</label>
    <input type="text" name="comment[content]" id="comment_content">
    <input type="submit" name="commit" value="Add Comment" data-disable-with="Add Comment">
  </form>
  `
  return commentFormHtml
}
