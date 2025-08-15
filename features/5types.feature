Feature: the types pages

Example: has 16 subtypes
Given I am on the types page
Then all behaviors should be linked

Scenario: can select my type
Given I am on the types page
When I follow my links
Then I should be on my page

Scenario: can find your type
Given I am on the types page
When I follow your links
Then I should be on your page
