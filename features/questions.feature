Feature: questions page

Scenario: the questions page starts with 4 realms
Given I am on the questions page
Then there should be 4 answer links

Scenario: the questions page allows you to choose which realm to start with
Given I am on the questions page
When I follow the 'People' link
Then I should see 'Question #1 of 3'

Scenario: choosing a subtype restricts the realms to 3
Given I am on the questions page
When I follow the 'People' link
  And I follow the 'listen to music' link
Then the 'People' link should be disabled

Scenario: choosing a realm presents 4 choices
Given I am on the questions page
When I follow the 'People' link
Then there should be 8 answer links

Scenario: the questions page allows you to get to my page
Given I am on the questions page
When I follow the 'People' link
  And I follow the 'preach' link
  And I follow the 'Things' link
  And I follow the 'salary' link
  And I follow the 'Ideas' link
  And I follow the 'facts' link
Then I should be on my page
  And the 'Me' link should be disabled

Scenario: the questions page doesnt always get to my page
Given I am on the questions page
When I follow the 'People' link
  And I follow the 'music' link
  And I follow the 'Things' link
  And I follow the 'cash' link
  And I follow the 'Places' link
  And I follow the 'protein' link
Then I should NOT be on my page
  And the 'Me' link should NOT be disabled
