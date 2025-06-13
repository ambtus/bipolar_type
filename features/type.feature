Feature: the type page

Scenario: shows all subtypes
Given I am on my page
Then I should see all Subtype acts

Scenario: for my type describes my do's
Given I am on my page
When I follow the 'do this' link
Then I should see all my do's
  But I should NOT see your do's

Scenario: for your type describes your do's
Given I am on your page
When I follow the 'do this' link
Then I should see all your do's
  But I should NOT see my do's

Scenario: can show just one realm at a time
Given I am on my page
When I follow the 'People' link
Then I should see all People acts
  But I should NOT see Places acts
  And the 'People' link should be disabled
  And the 'All' link should NOT be disabled

Scenario: can get back to all four
Given I am on my page
When I follow the 'People' link
  And I follow the 'All' link
Then I should see all Subtype acts
  And the 'People' link should NOT be disabled
  But the 'All' link should be disabled

