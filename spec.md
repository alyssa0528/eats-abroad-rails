# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (City has_many Restaurants)
- [x] Include at least one belongs_to relationship (Comment belongs_to Restaurant and belongs_to Chef)
- [x] Include at least one has_many through relationship (Chef has_many Restaurants through Comments; Restaurants has_many Chefs through Comments)
- [x] The "through" part of the has_many through includes at least one user submittable attribute (comments.content)
- [x] Include reasonable validations for simple model objects (Chef: validate presence of name and email and validate uniqueness of email; Comment: validate minimum length of 10 for content; Restaurant: validate presence of name and city_id)
- [ ] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
- [x] Include signup (new and create actions in Chefs controller)
- [x] Include login (new and create actions in Sessions controller)
- [x] Include logout (destroy action in Sessions controller)
- [x] Include third party signup/login (Facebook via OmniAuth)
- [x] Include nested resource show or index (cities/:id/restaurants)
- [x] Include nested resource "new" form (restaurants/:id/comments/new)
- [ ] Include form display of validation errors (form URL e.g. /recipes/new)

Confirm:
- [ ] The application is pretty DRY
- [ ] Limited logic in controllers
- [ ] Views use helper methods if appropriate
- [ ] Views use partials if appropriate
