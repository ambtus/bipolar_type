Feature: the type page

Scenario: gives some personal info
Given I am on my type page
Then I should see 'financial freedom'

Scenario: has links to two bipolars
Given I am on my type page
Then two bipolars should be linked

Scenario: has a working link to a bipolar
Given I am on my type page
When I follow the 'flee' link
Then I should be on my bipolar page

Scenario: breadcrumbs
Given I am on my type page
Then I should see the first breadcrumb
  And I should see the second breadcrumb
  And I should see the third breadcrumb
  And I should see the fourth breadcrumb
