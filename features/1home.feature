Feature: the home page

Scenario: gives some background
Given I am on the homepage
Then I should see '1980s'

Scenario: has a link to wikipedia bipolar
Given I am on the homepage
Then the 'bipolar' link should NOT be disabled

Scenario: has a link to wikipedia jung
Given I am on the homepage
Then the 'personality type' link should NOT be disabled

Scenario: has an imbedded link to the bipolar page
Given I am on the homepage
When I follow the 'cycle' link
Then I should be on the bipolar page

Scenario: has an imbedded link to the type page
Given I am on the homepage
When I follow the 'symptoms' link
Then I should be on the symptoms page

Scenario: has a link to wikipedia falsifiable
Given I am on the homepage
Then the 'falsifiable' link should NOT be disabled

Scenario: has a link to my page
Given I am on the homepage
When I follow the 'me' link
Then I should be on my page
