Feature: the type page

Scenario: uses your words
Given I have changed the word for UFS to plugh
When I am on your page
Then I should see plugh
  And I should NOT see the default word for UFS
