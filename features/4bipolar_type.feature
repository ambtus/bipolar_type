Feature: the types page

Scenario: starts with the first mood
Given I am on the types page
Then I should see the first four subtypes

Scenario: then the second mood
Given I am on the types page
When I choose my subtype
Then I should see the second four subtypes

Scenario: then the third mood
Given I am on the types page
When I choose my subtype
  And I choose my subtype
Then I should see the third four subtypes

Scenario: then the fourth mood
Given I am on the types page
When I choose my subtype
  And I choose my subtype
  And I choose my subtype
Then I should see the fourth four subtypes

Scenario: then the skew
Given I am on the types page
When I choose my subtype
  And I choose my subtype
  And I choose my subtype
  And I choose my subtype
Then I should see the two skews

Scenario: then me
Given I am on the types page
When I choose my subtype
  And I choose my subtype
  And I choose my subtype
  And I choose my subtype
  And I choose my skew
Then I should be on my page
