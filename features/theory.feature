Feature: the theory page

Scenario: shows a circle
Given I am on the theory page
Then I should see Manic
  But I should NOT see Bad

Scenario: lists the realms
Given I am on the theory page
Then I should see Realm names

Scenario: has links to the realms page
Given I am on the theory page
When I follow the 'People' link
Then I should be on the realms page

