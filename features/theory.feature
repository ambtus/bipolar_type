Feature: the theory page

Scenario: shows the four attitudes
Given I am on the theory page
Then I should see Attitude names

Scenario: lists the four realms
Given I am on the theory page
Then I should see Realm names

Scenario: has links to the realm pages
Given I am on the theory page
When I follow the 'People' link
Then I should be on the realms page
  And the 'People' link should be disabled

Scenario: has links to the attitude pages
Given I am on the theory page
When I follow the 'Fight' link
Then I should be on the attitudes page
  And the 'Fight' link should be disabled

