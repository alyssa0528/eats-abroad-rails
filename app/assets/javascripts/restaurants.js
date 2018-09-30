$(() => {
  bindClickListeners()
})

const bindClickListeners = function() {
  $('#all_restaurants').on('click', function(e) {
    e.preventDefault();
    history.pushState(null, null, "restaurants") //updates URL
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
    history.pushState(null, null, `restaurants/${id}`)
    fetch(`/restaurants/${id}.json`)
      .then(response => response.json())
      .then(restaurant => {
        // append restaurant JSON object to the #body-container div
        let newRestaurant = new Restaurant(restaurant);
        console.log(restaurant)
        let restaurantHtml = newRestaurant.formatShow();
        $('#body-container').append(restaurantHtml)
      })
    })
    //hijack new restaurant form
    //on submit, hijack form
    //get input
  $('#new_restaurant').on('submit', function(e) { //#new-restaurant is form id; need id for dropdown
    e.preventDefault();
    //get form input values...
    //console.log($(this))
    let $formValues = $('#new_restaurant :input')
    console.log($formValues)
    //$('#body-container').html('')

  })
}

function Restaurant(restaurant) {
  this.id = restaurant.id
  this.name = restaurant.name
  this.cuisine = restaurant.cuisine
  this.city = restaurant.city
  this.comments = restaurant.comments
  this.chefs = restaurant.chefs
}

Restaurant.prototype.formatIndex = function() {
  let restaurantHtml = `
    <a href="/restaurants/${this.id}" class="show-link" data-id="${this.id}"><h1>${this.name}</h1></a>
    <p>${this.cuisine} | ${this.city.name}</p>
  `
  return restaurantHtml
}

//function printComments(comments) {
  //comments.content.forEach(function(comment) {
    //comment.content
    //debugger
    //comment.chef.name
//  })
//}

Restaurant.prototype.formatShow = function() {
  //debugger
  //let comments = printComments(this.comments)
  let restaurantHtml = `
    <h1>${this.name}</h1>
    <p>Cuisine: ${this.cuisine}</p>
    <p>City: ${this.city.name}</p>
    <p>Recommendations:</p>
    <ul>
      ${this.comments.map((comment) => `
        <li>
        ${comment.content}
        debugger
        </li>
      `)}
    </ul>
  ` //create button for "More Info" that will show comments for the restaurant
  return restaurantHtml
}
