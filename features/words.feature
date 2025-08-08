Feature: the words page

Scenario: shows your words
Given I have changed the word for UPE to plugh
When I am on the words page
Then 'plugh' should be entered in 'UPE'

Scenario: can be reset with button
Given I have changed the word for UPE to plugh
When I am on the words page
  And I press the 'reset to defaults' button
Then I should be on the words page
  And I should NOT see plugh
  And my cookies should be empty

Scenario: can be reset with blank
Given I have changed the word for UPE to plugh
When I am on the words page
  And I save blank for UPE
Then I should be on the words page
  And I should NOT see plugh
  And my cookies should be empty

Scenario: sets the cookies
Given I use a bookmark link to words page including 'GPE=xyzzy&UPE=plugh'
Then I should be on the words page
  And 'xyzzy' should be entered in 'GPE'
  And 'plugh' should be entered in 'UPE'
