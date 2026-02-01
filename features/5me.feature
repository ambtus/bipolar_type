Feature: the bipolar pages

Example: bipolar page lists my greens
Given I am on my page
Then my greens should be listed

Scenario: has a link to the home page
Given I am on my page
When I follow the 'Home' link
Then I should be on the homepage
