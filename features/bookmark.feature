Feature: the bookmark link

Scenario: includes changed words
Given I have changed the word for UPE to xyzzy
When I am on my page
Then I should have a bookmark link including 'UPE=xyzzy'

Scenario: works
Given I use a bookmark link to my page including 'UPE=xyzzy'
Then I should be on my page
  And I should see xyzzy

Scenario: removes old words
Given I have changed the word for UPE to xyzzy
When I use a bookmark link to my page including 'UME=guess'
Then I should be on my page
  And I should see guess
  But I should NOT see xyzzy

Scenario: replaces old words
Given I have changed the word for UPE to xyzzy
When I use a bookmark link to my page including 'UPE=walk'
Then I should be on my page
  And I should see walk
  But I should NOT see xyzzy
  And I should NOT see travel

Scenario: doesn't wipe out unchanged words
Given I have changed the word for UPE to xyzzy
When I am on my page
  And I follow the 'bookmark' link
Then I should see xyzzy
