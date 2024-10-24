Feature: questions page

Scenario: the questions page allows you to use your own words
Given I am on the questions page
When I follow the 'cookies' link
Then I should see 'save your words'

Scenario: the questions page allows you to choose an option
Given I am on the questions page
  And I press 'Words'
When I follow the 'emotionally thin' link
Then I should see 'Question #2 of 3'

Scenario: the questions page allows you to get to my page
Given I am on the questions page
  And I press 'Words'
When I follow the 'emotionally thin' link
  And I follow the 'physically fat' link
  And I follow the 'mentally weak' link
Then I should see 'BipolarType 3 of 24'
  And the 'Me' link should be disabled

Scenario: the questions page doesnt always get to my page
Given I am on the questions page
  And I press 'Words'
When I follow the 'emotionally thin' link
  And I follow the 'physically fat' link
  And I follow the 'mentally strong' link
Then I should NOT see 'BipolarType 3 of 24'
  And the 'Me' link should NOT be disabled

Scenario: the questions page uses your words
Given I have entered 'spiritually' for 'F'
  And I have entered 'materially' for 'T'
  And I am on the questions page
  And I press 'Words'
When I follow the 'spiritually thin' link
  And I follow the 'materially strong' link
  And I follow the 'physically fat' link
Then I should see 'BipolarType 3 of 24'

Scenario: the questions page says its easier
Given I am on the questions page
  And I press 'Words'
Then I should see 'It’s much easier to listen when I don’t have to talk.'
  And I should see 'It’s much easier to not talk when I can listen.'
  And I should see 'It’s much easier to eat when I don’t have to move.'
  And I should see 'It’s much easier to not move when I can eat.'

Scenario: answering one question makes it and its siblings disappear
Given I am on the questions page
  And I press 'Words'
When I follow the 'emotionally thin' link
Then I should NOT see 'It’s much easier to listen when I don’t have to talk.'
  And I should NOT see 'It’s much easier to not talk when I can listen.'
  And I should NOT see 'It’s much easier to eat when I don’t have to move.'
  But I should see 'It’s much easier to not move when I can eat.'
