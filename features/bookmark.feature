Feature: the bookmark link

Scenario: includes changed words
Given I have changed the word for 'UPE' to 'travel'
When I am on my page
Then I should have a bookmark link including 'UPE=travel'

Scenario: works
Given I use a bookmark link to my page including 'UPE=travel'
Then I should be on my page
  And I should see 'travel' 

Scenario: removes old words
Given I have changed the word for 'UPE' to 'travel'
When I use a bookmark link to my page including 'UME=guess'
Then I should be on my page
  And I should see 'guess' 
  But I should NOT see 'travel'