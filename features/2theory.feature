Feature: the theory page

Scenario: talks about the normal cycle
Given I am on the theory page
Then I should see the four normals

Scenario: talks about the bipolar cycle
Given I am on the theory page
Then I should see the four bipolars

Scenario: talks about the type cycle
Given I am on the theory page
Then I should see 'depends on your type'

Scenario: has a link to the home page
Given I am on the theory page
When I follow the 'home' link
Then I should be on the homepage
