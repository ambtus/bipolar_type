Feature: the types pages

Example: has 4 physical behaviors
Given I am on the types page
Then all attitudes should be linked

Scenario: can select my type
Given I am on the types page
When I follow my links
Then I should be on my page

Scenario: can find your type
Given I am on the types page
When I follow your links
Then I should be on your page

