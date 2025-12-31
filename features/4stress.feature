Feature: the strength page

Scenario: gives some personal info
Given I am on my stress page
Then I should see 'avoid stressful people'

Scenario: has a link two internals
Given I am on my stress page
Then two types should be linked

Scenario: has a link to the third question
Given I am on my stress page
When I follow the 'financial' link
Then I should be on my type page

Scenario: breadcrumbs
Given I am on my stress page
Then I should see the first breadcrumb
  And I should see the second breadcrumb
  And I should see the third breadcrumb
