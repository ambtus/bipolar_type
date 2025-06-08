Feature: realms page

Scenario: the theory page lists the realms
Given I am on the theory page
Then I should see 'People'
  And I should see 'Places'
  And I should see 'Things'
  And I should see 'Ideas'

Scenario: the theory page shows a generic table
Given I am on the theory page
Then I should see 'Stressed'
  But I should NOT see 'Stressful'

Scenario: realms page is customized
Given I am on the theory page
When I follow the 'People' link
Then I should see 'sing'
  But I should NOT see 'Stressed'

Scenario: can get to next realm without going back
Given I am on the theory page
When I follow the 'People' link
  And I follow the 'Things' link
Then I should see 'cash'
  But I should NOT see 'emote'
