Feature: the types page

Scenario: starts with the first hate
Given I am on the types page
Then I should see the first four reds

Scenario: then the second hate
Given I am on the types page
When I choose my first red
Then I should see the second four reds

Scenario: then the third hate
Given I am on the types page
When I choose my first red
  And I choose my second red
Then I should see the third four reds

Scenario: then the fourth hate
Given I am on the types page
When I choose my first red
  And I choose my second red
  And I choose my third red
Then I should see the fourth four reds

Scenario: then me
Given I am on the types page
When I choose my first red
  And I choose my second red
  And I choose my third red
  And I choose my fourth red
Then I should be on my page
