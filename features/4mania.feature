Feature: the mania page

Scenario: gives some personal info
Given I am on my mania page
Then I should see 'I only have one'

Scenario: has a link two internals
Given I am on my mania page
Then two natures should be linked

Scenario: has a link to the third question
Given I am on my mania page
When I follow the 'material' link
Then I should be on my nature page

Scenario: breadcrumbs
Given I am on my mania page
Then I should see the first breadcrumb
  And I should see the second breadcrumb
  And I should see the third breadcrumb
