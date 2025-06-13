Feature: the questions page

Scenario: allows you to choose between 16 actions
Given I am on the first question page
Then I should see Subtype actions

Scenario: allows you to choose which realm to start with
Given I am on the first question page
When I follow the 'Ideas' link
Then I should see #1
  And the link for GME should be first
  And the 'Ideas' link should be disabled
  But the 'People' link should NOT be disabled

Scenario: allows you to choose which attitude to start with
Given I am on the first question page
When I follow the 'Use Energy' link
Then I should see #1
  And the link for USE should be first
  And the 'Use Energy' link should be disabled
  But the 'People' link should NOT be disabled

Scenario: restricts future choices after choosing an action
Given I am on the first question page
  And I follow the link for GSE
Then I should see #2
  And the 'People' link should be disabled
  And the 'Get Energy' link should be disabled
  And I should NOT see the default word for GSE
  And the link for USS should be disabled

Scenario: takes you to a type after choosing three actions
Given I am on the first question page
When I follow the last link
  And I follow the last link
  And I follow the last link
Then I should be on a theory page
  But I should NOT be on my page

Scenario: can take you to your type
Given I am on the first question page
When I follow the link for USE
  And I follow the link for GFE
  And I follow the link for UPS
Then I should be on your page

Scenario: can take you to my type
Given I am on the first question page
When I follow the link for GSE
  And I follow the link for UMS
  And I follow the link for UFE
Then I should be on my page

Scenario: allows you to start over
Given I am on the first question page
When I follow the link for GSE
Then the 'Start Over' link should NOT be disabled

Scenario: uses your words
Given I have changed the word for GSE to xyzzy
When I am on the first question page
  Then I should see xyzzy
