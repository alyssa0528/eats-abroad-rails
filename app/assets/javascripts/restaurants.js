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
          //console.log(restaurantHtml)
          $('#body-container').append(restaurantHtml)
          //console.log(newRestaurant)
        })
      })
  })


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
