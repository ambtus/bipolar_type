Feature: the types page

Scenario: starts with the first mood
Given I am on the types page
Then I should see the first four subtypes

Scenario: then the second mood
Given I am on the types page
When I choose my first subtype
Then I should see the second four subtypes

Scenario: then the third mood
Given I am on the types page
When I choose my first subtype
  And I choose my second subtype
Then I should see the third four subtypes

Scenario: then the fourth mood
Given I am on the types page
When I choose my first subtype
  And I choose my second subtype
  And I choose my third subtype
Then I should see the fourth four subtypes

Scenario: then the skew
Given I am on the types page
When I choose my first subtype
  And I choose my second subtype
  And I choose my third subtype
  And I choose my fourth subtype
Then I should see the four foolishnesses

Scenario: then me
Given I am on the types page
When I choose my first subtype
  And I choose my second subtype
  And I choose my third subtype
  And I choose my fourth subtype
  And I choose my foolish
Then I should be on my page
