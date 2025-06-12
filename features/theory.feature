Feature: the theory page

Scenario: shows a simple table
Given I am on the theory page
Then I should see 'Manic'
  But I should NOT see 'Stressful'

Scenario: lists the realms
Given I am on the theory page
Then I should see all Realm names

Scenario: has links to the realm pages
Given I am on the theory page
Then the 'People' link should NOT be disabled