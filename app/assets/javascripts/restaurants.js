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
        //console.log(restaurant)
        let restaurantHtml = newRestaurant.formatShow();
        $('#body-container').append(restaurantHtml)
      })
    })
    //SHOW RECOMMENDATIONS BUTTON
    //hijack see  -recs button
    //have it reveal the <ul> of recommendations and the recommender's name
  $(document).on('click', '#see-recs', function(e) {
    e.preventDefault()
    //console.log("button's been clicked")
    //'this' here is the <a href="#" id="see-recs"> tag
    let $id = $(this)[0].pathname
    //console.log($id)
    fetch(`${$id}.json`)
      .then(response => response.json())
      .then(data => {
        //create a comment??
        //append html?
        //let newComment = new Comment(data.)
        //console.log(data.comments)
        let newRestaurant = new Restaurant(data);
        let restaurantHtml = newRestaurant.revealComments();
        $('#see-recs').replaceWith(restaurantHtml)
      })
  })
    //hijack existing restaurant form
  //$('#add_existing').on('submit', function(e) {
    //e.preventDefault();
    //console.log(this)
  //})
  //hijack new restaurant form
  //on submit, hijack form
  //get input
  $('#new_restaurant').on('submit', function(e) { //#new-restaurant is form id; need id for dropdown
    e.preventDefault();
    console.log("yo!")
    //
    //get form input values...
    console.log($(this).serialize())
    let formValues = $(this).serialize();

    let posting = $.post('/restaurants', formValues);

    posting.done(function(data) {
      console.log(data)
    })

    //let $newRestaurantName = $('input#restaurant_name').val()
    //let newRestaurantCuisine = $('input#restaurant_cuisine').val()
    //let newRestaurantCityId = $('select#restaurant_city_id').val()
    //let $formValues = $('#new_restaurant :input')
    //console.log($('input#restaurant_name').val())
    //POST REQUEST TO /RESTAURANTS
    //$('#body-container').html('')
    //$('#body-container').append(`<h1>Add a comment for ${$newRestaurantName}:</h1>`)
  })
}

function Restaurant(restaurant) { //reification (turning raw data and turning it into a JS object)
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

Restaurant.prototype.formatShow = function() {
  //debugger
  //let comments = printComments(this.comments)
  let restaurantHtml = `
    <h1>${this.name}</h1>
    <p>Cuisine: ${this.cuisine}</p>
    <p>City: ${this.city.name}</p>
    <p>Recommended by:</p>
    <ul>
      ${this.chefs.map((chef) => `
        <li>
        <a href="/chefs/${chef.id}" class="chef_links">${chef.name}</a>
        </li>
        `
      ).join('')
    }
    </ul>

    <a href="#" id="see-recs">See Recommendations</a>
    `
    //create button for "More Info" that will show comments for the restaurant
  return restaurantHtml
}

function Comment(comment) {
  this.id = comment.id
  this.content = comment.content
  this.chef = comment.chef
  this.restaurant = comment.restaurant
}

Restaurant.prototype.revealComments = function() {
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
  return recHtml
}
