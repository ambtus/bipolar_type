Feature: the type pages

Example: my type page lists my subtypes
When I am on my type page
Then my subtypes should be linked

Example: your type page does not list my subtypes
When I am on your type page
Then my subtypes should NOT be linked
