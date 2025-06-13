Feature: the bookmark link

Scenario: includes changed words
Given I have changed the word for UFE to xyzzy
When I am on my page
Then I should have a bookmark link including 'UFE=xyzzy'

Scenario: sets the cookies
Given I use a bookmark link to my page including 'UFE=xyzzy'
Then I should be on my page
  And I should see xyzzy

Scenario: removes old words
Given I have changed the word for UFE to xyzzy
When I use a bookmark link to my page including 'UFE=plugh'
Then I should be on my page
  And I should see plugh
  But I should NOT see xyzzy

Scenario: replaces old words
Given I have changed the word for UFE to xyzzy
When I use a bookmark link to my page including 'UFE=plugh'
Then I should be on my page
  And I should see plugh
  But I should NOT see xyzzy
  And I should NOT see the default word for UFE

Scenario: doesn't wipe out unchanged words
Given I have changed the word for UFE to xyzzy
When I am on my page
  And I follow the 'bookmark' link
Then I should see xyzzy
