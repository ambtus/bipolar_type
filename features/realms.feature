Feature: the realms page

Scenario: has links to other realms
Given I am on the theory page
When I follow the 'People' link
Then the 'Things' link should NOT be disabled
  And the 'Theory' link should NOT be disabled
  But the 'People' link should be disabled

Scenario: shows basic get and use
Given I am on the theory page
When I follow the 'People' link
Then I should see People gets
  And I should see People uses

Scenario: shows actions
Given I am on the theory page
When I follow the 'People' link
Then I should see People actions
  But I should NOT see Places actions

Scenario: uses your words
Given I have changed the word for UEE to plugh
When I am on the theory page
  And I follow the 'People' link
Then I should see plugh
  And I should NOT see the default word for UEE
