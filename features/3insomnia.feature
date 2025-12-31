Feature: the insomnia page

Scenario: gives some personal info
Given I am on my insomnia page
Then I should see 'my mind'

Scenario: has a link three intakes
Given I am on my insomnia page
Then three intakes should be linked

Scenario: has a link to the third question
Given I am on my insomnia page
When I follow the 'watching' link
Then I should be on the stress page

Scenario: breadcrumbs
Given I am on my insomnia page
Then I should see the first breadcrumb
  And I should see the second breadcrumb
