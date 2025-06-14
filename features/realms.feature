Feature: the realms page

Scenario: has links to other realms
Given I am on the theory page
When I follow the 'People' link
Then the 'Things' link should NOT be disabled

Scenario: shows episodes
Given I am on the theory page
When I follow the 'People' link
Then I should see People episodes

Scenario: shows actions
Given I am on the theory page
When I follow the 'People' link
Then I should see People actions
  But I should NOT see Places actions

Scenario: uses your words
Given I have changed the word for USE to plugh
When I am on the theory page
  And I follow the 'People' link
Then I should see plugh
  And I should NOT see the default word for USE
