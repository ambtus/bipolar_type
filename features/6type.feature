Feature: the type pages

Example: type page lists my subtypes
Given I am on my type page
Then my moods should be listed

Example: type page lists my behaviors
Given I am on my type page
Then my dos should be linked

Example: type page lists my behaviors
Given I am on my type page
Then my donts should be linked

Example: can get to sibling from my type page
Given I am on my type page
When I follow my sibling
Then I should be on my sibling page

Example: can get to similar from my type page
Given I am on my type page
When I follow my similar
Then I should be on my similar page

Example: can get to different from my type page
Given I am on my type page
When I follow my different
Then I should be on my different page

Example: can get to mimic from my type page
Given I am on my type page
When I follow my mimic
Then I should be on my mimic page

Scenario: breadcrumbs
Given I am on my type page
Then I should see the first breadcrumb
  And I should see the second breadcrumb
  And I should see the third breadcrumb
  And I should see the fourth breadcrumb
  And I should see the fifth breadcrumb
