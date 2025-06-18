Feature: the types page

Scenario: shows the type actions
Given I am on the types page
Then I should see Subtype actions

Scenario: uses your words
Given I have changed the word for USE to plugh
When I am on the types page
Then I should see plugh
  And I should NOT see the default word for USE

Scenario: indicates sort
Given I am on the types page
  And the 'Bored' link should be disabled
When I follow the 'Anxious' link
Then the 'Anxious' link should be disabled
  But the 'Bored' link should NOT be disabled

