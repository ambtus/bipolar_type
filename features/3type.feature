Feature: the type pages

Example: type page lists my behaviors
When I am on my type page
Then my behaviors should be visible

Example: type page describes your behaviors
When I am on your type page
Then your behaviors should be visible

Example: type page does not describe your behaviors
When I am on my type page
Then your behaviors should NOT be visible

Example: type page does not describe my behaviors
When I am on your type page
Then my behaviors should NOT be visible

