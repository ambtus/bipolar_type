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

Scenario: has a link to the theory page
Given I am on the homepage
When I follow the 'theory' link
Then I should be on the theory page

Scenario: has a link to wikipedia falsifiable
Given I am on the homepage
Then the 'falsifiable' link should NOT be disabled

Scenario: has a link to my page
Given I am on the homepage
When I follow the 'me' link
Then I should be on my page
