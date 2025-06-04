Feature: questions page

Scenario: the questions page allows you to use your own words
Given I am on the questions page
When I follow the 'cookies' link
Then I should see 'save your words'

Scenario: the questions page allows you to choose an option
Given I am on the questions page
When I follow the 'Listen to music' link
Then I should see 'Question #2 of 3'

Scenario: choosing an option restricts the possibilities to 16 subtypes
Given I am on the questions page
Then there should be 16 answer links

Scenario: choosing an option restricts the possibilities to 9 + you
Given I am on the questions page
When I follow the 'Listen to music' link
Then there should be 10 answer links

Scenario: choosing two options restricts the possibilities to 4 + you
Given I am on the questions page
When I follow the 'Listen to music' link
  And I follow the 'Lie down' link
Then there should be 5 answer links

Scenario: the questions page allows you to get to my page
Given I am on the questions page
When I follow the 'Listen to music' link
  And I follow the 'Lie down' link
  And I follow the 'Pay cash' link
Then I should be on my page
  And the 'Me' link should be disabled

Scenario: the questions page doesnt always get to my page
Given I am on the questions page
When I follow the 'Listen to music' link
  And I follow the 'Lie down' link
  And I follow the 'Use credit' link
Then I should NOT be on my page
  And the 'Me' link should NOT be disabled

Scenario: the questions page uses your words
Given I have entered 'listen for emotion' for 'FP'
  And I have entered 'use logic' for 'NJ'
  And I am on the questions page
When I follow the 'Listen for emotion' link
  And I follow the 'Use logic' link
  And I follow the 'Lie down' link
Then I should be on my page

Scenario: the questions page shows all subtypes
Given I am on the questions page
  And I press 'Symbols'
Then I should see all subtypes

