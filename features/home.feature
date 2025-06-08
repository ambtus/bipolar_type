Feature: home page

Scenario: the home page shows bt history
Given I am on the homepage
Then I should see 'since the early 1980s'

Scenario: the home page has a link to my page
Given I am on the homepage
When I follow the 'me' link
Then I should be on my page

Scenario: the home page has a link to the theory page
Given I am on the homepage
When I follow the 'theory' link
Then I should see 'People | Places | Things | Ideas'

Scenario: the home page has a link to the questions page
Given I am on the homepage
When I follow the 'you' link
Then I should see 'Please choose one of the above'

