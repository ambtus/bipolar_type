Feature: the words page

Scenario: lists the defaults
Given I am on the words page
Then I should see all Subtype acts
  And I should see all Subtype actions

Scenario: reflects changed words
Given I have changed the word for GPE to NomNom
When I am on the words page
Then 'NomNom' should be entered in 'GPE'

Scenario: can be used to change the type page
Given I have changed the word for GPE to NomNom
When I am on your page
Then I should see NomNom
  And I should NOT see carbs

Scenario: can be used to change the realms page
Given I have changed the word for GPE to NomNom
When I am on the theory page
  And I follow the 'Places' link
Then I should see NomNom
  And I should NOT see carbs

Scenario: can be reset
Given I have changed the word for GPE to NomNom
When I am on the words page
  And I follow the 'reset to defaults' link
Then I should be on the words page
  And I should NOT see NomNom
