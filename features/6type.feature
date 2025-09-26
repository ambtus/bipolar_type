Feature: the type pages

Example: type page lists my goals
When I am on my type page
Then my goals should be visible

Example: type page lists your goals
When I am on your type page
Then my goals should NOT be visible

Example: type page lists my balances
When I am on my type page
Then my balances should be visible

Example: type page lists your balances
When I am on your type page
Then my balances should NOT be visible
