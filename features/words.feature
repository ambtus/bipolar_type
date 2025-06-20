Feature: the words page

Scenario: lists the defaults
Given I am on the words page
Then I should see Subtype actions

Scenario: shows your words
Given I have changed the word for UEE to plugh
When I am on the words page
Then 'plugh' should be entered in 'UEE'

Scenario: can be reset
Given I have changed the word for UEE to plugh
When I am on the words page
  And I follow the 'reset to defaults' link
Then I should be on the words page
  And I should NOT see plugh
  And my cookies should be empty
