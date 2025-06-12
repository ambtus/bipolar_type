Feature: the home page

Scenario: shows some background
Given I am on the homepage
Then I should see 'since the early 1980s'

Scenario: has a contextual link to the theory page
Given I am on the homepage
When I follow the 'theory' link
Then I should be on the theory page
  And the 'Theory' link should be disabled

Scenario: has a contextual link to my page
Given I am on the homepage
When I follow the 'me' link
Then I should be on my page
  And the 'Me' link should be disabled

Scenario: has a contextual link to the answers page
Given I am on the homepage
When I follow the 'you' link
Then I should be on the answers page
  And the 'You' link should be disabled

Scenario: has a contextual link to the words page
Given I am on the homepage
When I follow the 'words' link
Then I should be on the words page
  And the 'Words' link should be disabled

Scenario: has a contextual link to my words
Given I am on the homepage
When I follow the 'I use' link
Then 'close your eyes & think' should be entered in 'UMS'
