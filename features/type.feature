Feature: the type page

Scenario: shows your does by default
Given I am on your page
Then I should see your dos
  But I should NOT see your mores
  And I should NOT see your donts
  And I should NOT see your episodes
  And the 'do this' link should be disabled

Scenario: can show all subtypes
Given I am on my page
When I follow the 'all' link
Then I should see Subtype actions
  And the 'all' link should be disabled
  But the 'do this' link should NOT be disabled

Scenario: can show your mores
Given I am on your page
When I follow the 'so you can do more' link
Then I should see your mores
  But I should NOT see your dos
  And the 'so you can do more' link should be disabled
  But the 'do this' link should NOT be disabled

Scenario: can show your donts
Given I am on your page
When I follow the 'instead of that' link
Then I should see your donts
  But I should NOT see your episodes
  And I should NOT see your dos
  And I should NOT see your mores
  And the 'instead of that' link should be disabled
  But the 'do this' link should NOT be disabled

Scenario: can show your episodes
Given I am on your page
When I follow the 'and less of' link
Then I should see your episodes
  But I should NOT see your donts
  And I should NOT see your dos
  And I should NOT see your mores
  And the 'and less of' link should be disabled
  But the 'do this' link should NOT be disabled

Scenario: uses your words
Given I have changed the word for USE to plugh
When I am on your page
Then I should see plugh
  And I should NOT see the default word for USE

Scenario: can show one realm
Given I am on my page
When I follow the 'People' link
Then I should see People actions
  But I should NOT see Places actions
  And the 'People' link should be disabled
  But the 'do this' link should NOT be disabled

Scenario: can show another realm
Given I am on my page
When I follow the 'Places' link
Then I should see Places actions
  But I should NOT see People actions
  And the 'Places' link should be disabled
  But the 'do this' link should NOT be disabled

Scenario: can show one attitude
Given I am on my page
When I follow the 'Get Strength' link
Then I should see rest actions
  But I should NOT see fight actions
  And the 'Get Strength' link should be disabled
  But the 'do this' link should NOT be disabled

Scenario: can show another attitude
Given I am on my page
When I follow the 'Use Strength' link
Then I should see fight actions
  But I should NOT see rest actions
  And the 'Use Strength' link should be disabled
  But the 'do this' link should NOT be disabled
