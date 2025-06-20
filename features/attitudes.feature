Feature: the attitudes page

Scenario: has links to other attitudes
Given I am on the theory page
When I follow the 'Fight' link
Then the 'Flee' link should NOT be disabled
  And the 'Theory' link should NOT be disabled
  But the 'Fight' link should be disabled

Scenario: shows akas
Given I am on the theory page
When I follow the 'Fight' link
Then I should see Fight akas
  But I should NOT see Flee akas

Scenario: shows actions
Given I am on the theory page
When I follow the 'Fight' link
Then I should see Fight actions
  But I should NOT see Flee actions

Scenario: uses your words
Given I have changed the word for UES to plugh
When I am on the theory page
  And I follow the 'Fight' link
Then I should see plugh
  And I should NOT see the default word for UES
