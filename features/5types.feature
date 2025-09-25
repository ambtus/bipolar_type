Feature: the types pages

Example: show 16 subtypes
Given I am on the types page
Then all subtypes should be linked

Scenario: can select my type
Given I am on the types page
When I follow my links
Then I should be on my page

Scenario: can select your type
Given I am on the types page
When I follow your links
Then I should be on your page

Scenario: can get to my type from mbti pairs
Given I am on the types page
When I follow my path
Then I should be on my page

Scenario: can get to your type from mbti pairs
Given I am on the types page
When I follow your path
Then I should be on your page

Example: list of types starts high
Given I am on the types page
Then I should have 40 list items

Example: list of types decreases with first choice
Given I am on the types page
When I follow one subtype
Then I should have 22 list items

Example: list of types decreases further with second choice
Given I am on the types page
When I follow two subtypes
Then I should have 18 list items
