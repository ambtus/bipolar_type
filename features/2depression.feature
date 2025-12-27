Feature: the depression page

Scenario: gives some personal info
Given I am on the depression page
Then I should see 'my body'

Scenario: has a link all four internals
Given I am on the depression page
Then all internals should be linked

Scenario: has a link to the second question
Given I am on the depression page
When I follow the 'body' link
Then I should be on the insomnia page

Scenario: breadcrumbs
Given I am on the depression page
Then I should see the first breadcrumb
