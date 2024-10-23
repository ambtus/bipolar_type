Feature: cookies page

Scenario: the cookies page allows you to use your own words
Given I am on the cookies page
When I enter 'spiritually' for 'F'
  And I press 'Save'
Then I should see 'spiritually' within 'F'

