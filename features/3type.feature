Feature: the type page

Scenario: talks about zeitgebers
Given I am on the type page
Then 'zeitgeber' should link to wikipedia

Scenario: talks about the four realms
Given I am on the type page
Then I should see the four realms

Scenario: has a link to the home page
Given I am on the bipolar page
When I follow the 'Home' link
Then I should be on the homepage
