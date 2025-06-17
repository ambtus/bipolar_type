Feature: the types page

Scenario: shows the unhappys
Given I am on the types page
Then I should see Attitude unhappy
  And the 'bored' link should be disabled

Scenario: indicates sort
Given I am on the types page
When I follow the 'anxious' link
Then the 'anxious' link should be disabled
  But the 'bored' link should NOT be disabled

