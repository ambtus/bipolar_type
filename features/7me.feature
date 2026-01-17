Feature: the bipolar pages

Example: bipolar page lists my moods
Given I am on my page
Then my moods should be listed

Example: bipolar page lists my dos
Given I am on my page
Then my dos should be listed

Example: bipolar page lists my donts
Given I am on my page
Then my donts should be listed

Example: can get to my sibling from my page
Given I am on my page
When I follow my sibling
Then I should be on my sibling page

Example: can get to my similar from my page
Given I am on my page
When I follow my similar
Then I should be on my similar page

Example: can get to my different from my page
Given I am on my page
When I follow my different
Then I should be on my different page

Scenario: has a link to the home page
Given I am on my page
When I follow the 'Home' link
Then I should be on the homepage
