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

Example: can get to sibling from my type page
When I am on my type page
And I follow my sibling
Then I should be on my sibling page

Example: can get to similar from your type page
When I am on your type page
And I follow your similar
Then I should be on your similar page

Example: old types give alert
When I am on a bad type page
Then I should see an alert
And I should be on the types page
