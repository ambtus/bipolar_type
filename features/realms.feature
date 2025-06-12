Feature: the realms page

Scenario: shows a square
Given I am on the theory page
When I follow the 'People' link
Then I should see 'The Bad'
  But I should NOT see 'Manic'

Scenario: shows some exposition
Given I am on the theory page
When I follow the 'People' link
Then I should see 'new people'

Scenario: has links to other realms
Given I am on the theory page
When I follow the 'People' link
Then the 'Things' link should NOT be disabled

Scenario: for People shows person actions
Given I am on the theory page
When I follow the 'People' link
Then I should see 'sing'
  But I should NOT see 'cash'
  And I should NOT see 'gather'
  And I should NOT see 'choose'

Scenario: for Places shows place actions
Given I am on the theory page
When I follow the 'Places' link
Then I should see 'gather'
  But I should NOT see 'cash'
  And I should NOT see 'sing'
  And I should NOT see 'choose'

Scenario: for Ideas shows idea actions
Given I am on the theory page
When I follow the 'Ideas' link
Then I should see 'choose'
  But I should NOT see 'cash'
  And I should NOT see 'sing'
  And I should NOT see 'gather'

Scenario: for Things shows thing actions
Given I am on the theory page
When I follow the 'Things' link
Then I should see 'cash'
  But I should NOT see 'choose'
  And I should NOT see 'sing'
  And I should NOT see 'gather'
