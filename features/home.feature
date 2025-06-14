Feature: the home page

Scenario: gives some background
Given I am on the homepage
Then I should see 1980s

Scenario: has a link to my page
Given I am on the homepage
When I follow the 'me' link
Then I should be on my page
