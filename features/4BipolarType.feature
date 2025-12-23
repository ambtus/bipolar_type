Feature: the types pages

Example: show 16 subtypes
Given I am on the types page
Then all subtypes should be linked

Scenario: can select my type
Given I am on the types page
When I follow the links leading to me
Then I should be on my page

Scenario: can select your type
Given I am on the types page
When I follow the links leading to you
Then I should be on your page

Scenario: can get to my type directly
Given I am on the types page
When I follow my type
Then I should be on my page

Scenario: can get to your type directly
Given I am on the types page
When I follow your type
Then I should be on your page

Example: number of choices starts high
Given I am on the types page
Then I should have 16 subtype links

Example: number of choices decreases with first choice
Given I am on the types page
When I choose one subtype
Then I should have 9 subtype links

Example: number of choices decreases further with second choice
Given I am on the types page
When I choose two subtypes
Then I should have 4 subtype links
