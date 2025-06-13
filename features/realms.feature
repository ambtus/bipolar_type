Feature: the realms page

Scenario: shows a square
Given I am on the theory page
When I follow the 'People' link
Then I should see Bad
  But I should NOT see Manic

Scenario: shows some exposition
Given I am on the theory page
When I follow the 'People' link
Then I should see subtypes

Scenario: has links to other realms
Given I am on the theory page
When I follow the 'People' link
Then the 'Things' link should NOT be disabled

Scenario: for People shows person actions
Given I am on the theory page
When I follow the 'People' link
Then I should see People actions
  But I should NOT see Places actions

Scenario: for Places shows place actions
Given I am on the theory page
When I follow the 'Places' link
Then I should see Places actions
  But I should NOT see Ideas actions

Scenario: for Ideas shows idea actions
Given I am on the theory page
When I follow the 'Ideas' link
Then I should see Ideas actions
  But I should NOT see Things actions

Scenario: for Things shows thing actions
Given I am on the theory page
When I follow the 'Things' link
Then I should see Things actions
  But I should NOT see People actions
