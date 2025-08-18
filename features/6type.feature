Feature: the type pages

Example: type page lists my advice
Given I am on the types page
When I follow my links
Then my advice should be visible
  But your advice should NOT be visible

Example: type page lists your goals
Given I am on the types page
When I follow your links
Then your goals should be visible
  But my goals should NOT be visible

Example: type page describes my subgoals
Given I am on the types page
When I follow my links
Then my subgoals should be clickable

Example: type page describes your episodes
Given I am on the types page
When I follow your links
Then your episodes should be clickable

Example: type page describes my problems
Given I am on the types page
When I follow my links
Then my problems should be clickable

Example: type page describes your solutions
Given I am on the types page
When I follow your links
Then your solutions should be clickable
