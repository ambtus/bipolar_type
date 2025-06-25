Feature: the types pages

Scenario: uses your words
Given I have changed the word for GPE to plugh
When I am on the types page
Then I should see plugh
  And I should NOT see the default word for GPE

Scenario: can select my type
Given I am on the types page
When I follow my links
Then I should be on my page

Scenario: can find your type
Given I am on the types page
When I follow your links
Then I should be on your page
