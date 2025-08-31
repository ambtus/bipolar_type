Feature: the episodes page

Scenario: describes four episodes
Given I am on the episodes page
Then all episodes should be listed

Scenario: describes four reactions
Given I am on the episodes page
Then all reactions should be listed

Scenario: describes excess
Given I am on the episodes page
Then I should see compulsive
