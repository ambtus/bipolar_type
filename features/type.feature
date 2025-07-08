Feature: the type page

Scenario: shows all by default
Given I am on your page
Then I should see Subtype actions
  And the 'All' link should be disabled

Scenario: uses your words
Given I have changed the word for BSE to plugh
When I am on your page
Then I should see plugh
  And I should NOT see the default word for BSE

Scenario: can show one realm
Given I am on my page
When I follow the 'People' link
Then I should see People actions
  But I should NOT see Places actions
  And I should NOT see Things actions
  And I should NOT see Ideas actions
  And the 'People' link should be disabled
  But the 'All' link should NOT be disabled

Scenario: can show one attitude
Given I am on my page
When I follow the 'Move' link
Then I should see Move actions
  But I should NOT see Work actions
  And I should NOT see Rest actions
  And I should NOT see Feed actions
  And the 'Move' link should be disabled
  But the 'All' link should NOT be disabled
