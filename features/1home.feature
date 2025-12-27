Feature: the home page

Scenario: gives some personal info
Given I am on the homepage
Then I should see 'since I was diagnosed'

Scenario: has a link to wikipedia bipolar
Given I am on the homepage
Then 'bipolar disorder' should link to wikipedia

Scenario: has a link to wikipedia jung
Given I am on the homepage
Then 'personality type' should link to wikipedia

Scenario: has a link to wikipedia falsifiable
Given I am on the homepage
Then 'falsifiable' should link to wikipedia

Scenario: has a link to the first question
Given I am on the homepage
When I follow the 'Morning Depression' link
Then I should be on the depression page
