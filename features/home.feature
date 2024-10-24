Feature: home page

Scenario: the home page shows bt history
Given I am on the homepage
Then I should see 'since the early 1980s'

Scenario: the home page has a link to my page
Given I am on the homepage
When I follow the 'me' link
Then I should see 'BipolarType 3 of 24'

Scenario: the home page has a link to the cycle page
Given I am on the homepage
When I follow the 'Cycle' link
Then I should see 'natural rhythm'

Scenario: the home page has a link to the serenity page
Given I am on the homepage
When I follow the 'Serenity' link
Then I should see 'if and only if'

Scenario: the home page has a link to the things page
Given I am on the homepage
When I follow the 'Things' link
Then I should see 'F things'

Scenario: the home page has a link to the questions page
Given I am on the homepage
When I follow the 'you' link
Then I should see 'Question #1 of 3'

