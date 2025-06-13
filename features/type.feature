Feature: the type page

Scenario: for my types shows my do's
Given I am on my page
Then I should see all my do's
  But I should NOT see your do's
  And I should NOT see my don'ts
  And the 'do this' link should be disabled
  And the 'instead of that' link should NOT be disabled

Scenario: for your type describes your do's
Given I am on your page
Then I should see all your do's
  But I should NOT see my do's

Scenario: can show all subtypes
Given I am on my page
When I follow the 'show all' link
Then I should see all Subtype actions
  And the 'do this' link should NOT be disabled
  But the 'show all' link should be disabled

Scenario: can show just one realm at a time
Given I am on my page
When I follow the 'People' link
Then I should see all People actions
  But I should NOT see Places actions
  And the 'People' link should be disabled
  And the 'show all' link should NOT be disabled

Scenario: for my types can show my dont's
Given I am on my page
When I follow the 'instead of that' link
Then I should see all my dont's
  And I should NOT see my do's
  And the 'do this' link should NOT be disabled
  And the 'instead of that' link should be disabled
