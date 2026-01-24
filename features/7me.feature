Feature: the bipolar pages

Example: bipolar page lists my greens
Given I am on my page
Then my greens should be listed

Example: can get to my sibling from my page
Given I am on my page
When I follow my sibling
Then I should be on my sibling page

Example: can get to my friend from my page
Given I am on my page
When I follow my friend
Then I should be on my friend page

Scenario: has a link to the home page
Given I am on my page
When I follow the 'Home' link
Then I should be on the homepage
