Feature: the words page

Scenario: lists the defaults
Given I am on the words page
Then I should see all Subtype acts
  And I should see all Subtype actions

Scenario: reflects changed words
Given I have changed the word for 'GPE' to 'eat dessert'
When I am on the words page
Then 'eat dessert' should be entered in 'GPE'

Scenario: can be used to change the type page
Given I have changed the word for 'GPE' to 'eat dessert'
When I am on your page
Then I should see 'eat dessert'
  And I should NOT see 'carbs'

Scenario: can be used to change the realms page
Given I have changed the word for 'GPE' to 'eat dessert'
When I am on the theory page
  And I follow the 'Places' link
Then I should see 'eat dessert'
  And I should NOT see 'carbs'
