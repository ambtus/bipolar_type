Feature: the type pages

Example: type page lists my advice
When I am on my type page
Then my advice should be visible

Example: type page allows you to change words
Given I am on my type page
When I click the 'Change Words' button 2 times
Then my advice should NOT be visible

Example: type page allows you to change words multiple times
Given I am on your type page
When I click the 'Change Words' button 6 times
Then your advice should be visible

Example: type page describes your episodes
When I am on your type page
Then your episodes should be visible

Example: type page only shows important advice by default
Given I am on my type page
Then I should have 10 li elements

Example: type page allows you to show all advice
Given I am on my type page
When I click the 'Show All' button
Then I should have 15 li elements

Example: showing all does not change words
Given I am on my type page
When I click the 'Show All' button
Then my advices should be visible

Example: type page allows you to hide all advice
Given I am on my type page
When I click the 'Show All' button
  And I click the 'Show Important' button
Then I should have 10 li elements
