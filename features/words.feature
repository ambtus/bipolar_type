Feature: words page

Scenario: the word page lists the subtype acts
Given I am on the words page
Then I should see all Subtype acts
  And I should see all Subtype actions

Scenario: the word page allows you to see your changes on the words page
Given I have changed the word for 'GPE' to 'eat dessert'
When I am on the words page
Then 'eat dessert' should be entered in 'GPE'

Scenario: the word page allows you to see your changes on the type page
Given I have changed the word for 'GPE' to 'eat dessert'
When I am on your page
Then I should see 'eat dessert'
  And I should NOT see 'carbs'

Scenario: the word page allows you to see your changes on the realms page
Given I have changed the word for 'GPE' to 'eat dessert'
When I am on the theory page
  And I follow the 'Places' link
Then I should see 'eat dessert'
  And I should NOT see 'carbs'

Scenario: the type page has a bookmark link including words
Given I have changed the word for 'UPE' to 'travel'
When I am on my page
Then I should have a bookmark link including 'UPE=travel'

Scenario: the bookmark link works
Given I use a bookmark link to my page including 'UPE=travel'
Then I should be on my page
  And I should see 'travel' 
