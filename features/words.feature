Feature: the words page

Scenario: lists the defaults
Given I am on the words page
Then I should see all Attitude actions
  And I should see all Subtype actions

Scenario: reflects changed words
Given I have changed the word for USE to plugh
When I am on the words page
Then 'plugh' should be entered in 'USE'

Scenario: can be used to change the type page
Given I have changed the word for USE to plugh
When I am on your page
Then I should see plugh
  And I should NOT see sing

Scenario: can be used to change the realms page
Given I have changed the word for USE to plugh
When I am on the theory page
  And I follow the 'People' link
Then I should see plugh
  And I should NOT see sing

Scenario: can be reset
Given I have changed the word for USE to plugh
When I am on the words page
  And I follow the 'reset to defaults' link
Then I should be on the words page
  And I should NOT see plugh
  And my cookies should be empty
