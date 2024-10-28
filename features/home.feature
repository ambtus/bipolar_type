Feature: home page

Scenario: the home page shows bt history
Given I am on the homepage
Then I should see 'since the early 1980s'

Scenario: the home page has a link to my page
Given I am on the homepage
When I follow the 'me' link
Then I should be on my page

Scenario: the home page has a link to the cycle page
Given I am on the homepage
When I follow the 'Cycle' link
Then I should see 'Natural Rhythm'

Scenario: the home page has a link to the serenity page
Given I am on the homepage
When I follow the 'Serenity' link
Then I should see 'Help me CARE'

Scenario: the home page has a link to the things page
Given I am on the homepage
When I follow the 'Things' link
  And I press 'Things'
Then I should see 'F things'

Scenario: the home page has a link to the questions page
Given I am on the homepage
When I follow the 'you' link
Then I should see 'Question #1 of 3'

Scenario: the home page has a link to the types page
Given I am on the homepage
When I follow the '24 Types' link
Then I should see '24 BipolarTypes'
