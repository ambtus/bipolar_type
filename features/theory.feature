Feature: the theory page

Scenario: shows the four episodes
Given I am on the theory page
Then I should see Attitude episodes

Scenario: lists the four realms
Given I am on the theory page
Then I should see Realm names

Scenario: has links to the realms page
Given I am on the theory page
When I follow the 'People' link
Then I should be on the realms page
  And the 'People' link should be disabled

