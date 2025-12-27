Feature: the nature page

Scenario: gives some personal info
Given I am on my nature page
Then I should see 'financial freedom'

Scenario: has a link two types
Given I am on my nature page
Then two types should be linked

Scenario: has a link to a type
Given I am on my nature page
When I follow the 'flee' link
Then I should be on my type page

Scenario: breadcrumbs
Given I am on my nature page
Then I should see the first breadcrumb
  And I should see the second breadcrumb
  And I should see the third breadcrumb
  And I should see the fourth breadcrumb
