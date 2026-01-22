Feature: the bipolar page

Scenario: talks about the wise cycle
Given I am on the bipolar page
Then I should see the four wisdoms

Scenario: talks about the bipolar cycle
Given I am on the bipolar page
Then I should see the four episodes

Scenario: has a link to the home page
Given I am on the bipolar page
When I follow the 'Home' link
Then I should be on the homepage
