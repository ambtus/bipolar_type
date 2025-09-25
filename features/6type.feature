Feature: the type pages

Example: type page lists my goals
When I am on my type page
Then my goals should be visible

Example: type page lists your goals
When I am on your type page
Then my goals should NOT be visible
Example: type page describes your hows
When I am on your type page
Then your hows should be visible

Example: type page describes my hows
When I am on my type page
Then your hows should NOT be visible

Example: type page lists my natures
When I am on my type page
Then my natures should be visible

Example: type page lists your natures
When I am on your type page
Then my natures should NOT be visible

