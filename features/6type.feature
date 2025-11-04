Feature: the type pages

Example: type page lists my subtypes
When I am on my type page
Then my subtypes should be linked

Example: type page lists your subtypes
When I am on your type page
Then my subtypes should NOT be linked

Example: type page lists my behaviors
When I am on my type page
Then my behaviors should be linked
