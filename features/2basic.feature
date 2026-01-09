Feature: the basic personality page

Scenario: has a link for both basics
Given I am on the basic page
Then two types should be linked

Scenario: has a link to the second question
Given I am on the basic page
When I follow the 'e' link
Then I should be on the ip page

Scenario: breadcrumbs
Given I am on the basic page
Then I should see the first breadcrumb
