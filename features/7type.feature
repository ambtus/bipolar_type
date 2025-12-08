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

Example: type pages lists your behaviors
When I am on your type page
Then my behaviors should NOT be linked

Example: type page links to nature
When I am on my type page
Then my nature should be linked

Example: type page links to nature
When I am on your type page
Then my nature should NOT be linked

Example: can get to nature from type page
When I am on my type page
And I follow my nature
Then I should be on my nature page
