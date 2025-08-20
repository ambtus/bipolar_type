Feature: the type pages

Example: type page lists my advice
Given I am on the types page
When I follow my links
Then my advice should be visible
  But your advice should NOT be visible

Example: type page allows you to change words
Given I am on the types page
When I follow my links
  And I click the 'Change Words' button 2 times
Then my advice should NOT be visible

Example: type page allows you to change words multiple times
Given I am on the types page
When I follow your links
  And I click the 'Change Words' button 6 times
Then your advice should be visible

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
Then my symptoms should be clickable

Example: type page describes your solutions
Given I am on the types page
When I follow your links
Then your treatments should be clickable

Example: type page allows you to open all links
Given I am on the types page
When I follow my links
  And I click the 'Expand All' button
Then my problems should NOT be clickable

