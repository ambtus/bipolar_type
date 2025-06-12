Feature: the questions page

Scenario: allows you to choose between 16 actions
Given I am on the first question page
Then I should see all Subtype act

Scenario: allows you to choose which realm to start with
Given I am on the first question page
When I follow the 'Ideas' link
Then I should see 'Question #1 of 3'
  And I should see 'choose' before 'sing'
  And the 'Ideas' link should be disabled
  But the 'People' link should NOT be disabled

Scenario: allows you to choose which attitude to start with
Given I am on the first question page
When I follow the 'Get Energy' link
Then I should see 'Question #1 of 3'
  And I should see 'music' before 'sing'
  And the 'Get Energy' link should be disabled
  But the 'People' link should NOT be disabled

Scenario: restricts future choices after choosing an action 
Given I am on the first question page
  And I follow the 'listen to music' link
Then the 'People' link should be disabled
  And the 'Get Energy' link should be disabled
  And I should NOT see 'listen to music'
  And the 'eat carbs' link should be disabled

Scenario: takes you to a type after choosing three actions 
Given I am on the first question page
When I follow the last link
  And I follow the last link
  And I follow the last link
Then I should be on a theory page
  But I should NOT be on my page

Scenario: can take you to my type
Given I am on the first question page
When I follow the 'listen to music' link
  And I follow the 'eat protein' link
  And I follow the 'pay cash' link
Then I should be on my page


Scenario: allows you to start over
Given I am on the first question page
When I follow the 'music' link
Then the 'Start Over' link should NOT be disabled
