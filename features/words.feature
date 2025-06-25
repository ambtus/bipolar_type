Feature: the words page

Scenario: lists the defaults
Given I am on the words page
Then I should see Subtype actions

Scenario: shows your words
Given I have changed the word for BSE to plugh
When I am on the words page
Then 'plugh' should be entered in 'BSE'

Scenario: can be reset
Given I have changed the word for BSE to plugh
When I am on the words page
  And I follow the 'reset to defaults' link
Then I should be on the words page
  And I should NOT see plugh
  And my cookies should be empty

Scenario: sets the cookies
Given I use a bookmark link to words page including 'BFE=xyzzy&BSE=plugh'
Then I should be on the words page
  And 'xyzzy' should be entered in 'BFE'
  And 'plugh' should be entered in 'BSE'
