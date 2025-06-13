Feature: the type page

Scenario: shows your do's by default
Given I am on your page
Then I should see your dos
  And I should see your wants
  But I should NOT see your don'ts
  And I should NOT see your can'ts
  And the 'do' link should be disabled

Scenario: can show your do not's
Given I am on your page
When I follow the 'do not' link
Then I should NOT see your dos
  And I should NOT see your wants
  But I should see your don'ts
  And I should see your can'ts
  And the 'do not' link should be disabled
  But the 'do' link should NOT be disabled

Scenario: can show all subtypes
Given I am on my page
When I follow the 'both' link
Then I should see Subtype actions
  And the 'both' link should be disabled
  But the 'do' link should NOT be disabled

Scenario: can show one realm
Given I am on my page
When I follow the 'People' link
Then I should see People actions
  But I should NOT see Places actions
  And the 'People' link should be disabled
  But the 'do' link should NOT be disabled

Scenario: can show another realm
Given I am on my page
When I follow the 'Places' link
Then I should see Places actions
  But I should NOT see People actions
  And the 'Places' link should be disabled
  But the 'do' link should NOT be disabled

Scenario: can show just your dos without your wants
Given I am on your page
When I follow the 'do this' link
Then I should see your dos
  But I should NOT see your wants
  And the 'do this' link should be disabled
  But the 'do' link should NOT be disabled

Scenario: can show your wants
Given I am on your page
When I follow the 'so you can do this' link
Then I should see your wants
  But I should NOT see your dos
  And the 'so you can do this' link should be disabled
  But the 'do' link should NOT be disabled

Scenario: can show your don'ts
Given I am on your page
When I follow the 'instead of that' link
Then I should see your don'ts
  But I should NOT see your can'ts
  And I should NOT see your dos
  And I should NOT see your wants
  And the 'instead of that' link should be disabled
  But the 'do' link should NOT be disabled

Scenario: can show your can'ts
Given I am on your page
When I follow the 'instead of having to do that' link
Then I should see your can'ts
  But I should NOT see your don'ts
  And I should NOT see your dos
  And I should NOT see your wants
  And the 'instead of having to do that' link should be disabled
  But the 'do' link should NOT be disabled
