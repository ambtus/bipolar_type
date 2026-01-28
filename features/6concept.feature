Feature: the concept page

Scenario: with back button
Given I am on my page
When I follow the 'refuel (ip)' link
  And I follow the 'Back' link
Then I should be on my page

Scenario: with home button
Given I am on the ip concept page
When I follow the 'Home' link
Then I should be on the homepage

Scenario: action
Given I am on my page
When I follow the 'refuel (ip)' link
Then I should be on the concept page

Scenario: behavior
Given I am on my page
When I follow the 'lift weights (eSj)' link
Then I should be on the concept page
