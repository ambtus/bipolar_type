Feature: the type page

Scenario: shows all by default
Given I am on your page
Then I should see Subtype actions
  And the 'All' link should be disabled

Scenario: uses your words
Given I have changed the word for UEE to plugh
When I am on your page
Then I should see plugh
  And I should NOT see the default word for UEE

Scenario: can show one realm
Given I am on my page
When I follow the 'People' link
Then I should see People actions
  But I should NOT see Places actions
  And I should NOT see Things actions
  And I should NOT see Ideas actions
  And the 'People' link should be disabled
  But the 'All' link should NOT be disabled

Scenario: can show another realm
Given I am on my page
When I follow the 'Places' link
Then I should see Places actions
  But I should NOT see People actions
  And I should NOT see Things actions
  And I should NOT see Ideas actions
  And the 'Places' link should be disabled
  But the 'All' link should NOT be disabled

Scenario: can show one attitude
Given I am on my page
When I follow the 'Flee' link
Then I should see Flee actions
  But I should NOT see Fight actions
  And I should NOT see Rest actions
  And I should NOT see Digest actions
  And the 'Flee' link should be disabled
  But the 'All' link should NOT be disabled

Scenario: can show another attitude
Given I am on my page
When I follow the 'Fight' link
Then I should see Fight actions
  But I should NOT see Flee actions
  And the 'Fight' link should be disabled
  But the 'All' link should NOT be disabled
