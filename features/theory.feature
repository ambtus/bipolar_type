Feature: theory page

Scenario: the theory page lists the realms
Given I am on the theory page
Then I should see all Realm names

Scenario: the theory page shows a generic table
Given I am on the theory page
Then I should see 'Manic'
  But I should NOT see 'Stressful'

Scenario: the People realm page is customized
Given I am on the theory page
When I follow the 'People' link
Then I should see 'sing'
  But I should NOT see 'Manic'

Scenario: can get to next realm without going back
Given I am on the theory page
When I follow the 'People' link
  And I follow the 'Things' link
Then I should see 'cash'
  But I should NOT see 'sing'
