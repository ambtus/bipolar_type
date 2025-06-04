Feature: home page

Scenario: the home page shows bt history
Given I am on the homepage
Then I should see 'since the early 1980s'

Scenario: the home page has a link to my page
Given I am on the homepage
When I follow the 'me' link
Then I should be on my page

Scenario: the home page has a link to the realms page
Given I am on the homepage
When I follow the 'Realms' link
Then I should see 'People'

Scenario: the home page has a link to the cycle page
Given I am on the homepage
When I follow the 'Cycle' link
Then I should see 'Burn'

Scenario: the home page has a link to the questions page
Given I am on the homepage
When I follow the 'you' link
Then I should see 'Question #1 of 3'

