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
When I follow the link for F
Then I should see F actions
  But I should NOT see S actions
  And I should NOT see T actions
  And I should NOT see N actions
  And the link for F should be disabled
  But the 'All' link should NOT be disabled
  And the link for S should NOT be disabled

Scenario: can show one attitude
Given I am on my page
When I follow the link for TL
Then I should see TL actions
  But I should NOT see TR actions
  And I should NOT see BL actions
  And I should NOT see BR actions
  And the link for TL should be disabled
  But the 'All' link should NOT be disabled
  And the link for TR should NOT be disabled
