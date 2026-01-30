Feature: the concept page

Scenario: with back button
Given I am on my page
When I follow the 'refuel (ip)' link
Then there should be a 'Back' link

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
When I follow the 'music (iFp)' link
Then I should be on the concept page
