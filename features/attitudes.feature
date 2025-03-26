Feature: attitudes page

Scenario: the attitudes page lists the attitudes
Given I am on the attitudes page
Then I should see 'Energetic'
  And I should see 'Strong'
  And I should see 'Manic'
  And I should see 'Depressed'

Scenario: the attitudes page reflects cookies
Given I have entered 'up' for 'I'
When I am on the attitudes page
Then I should see 'Up'

Scenario: the attitudes page defaults to short versions
Given I am on the attitudes page
Then I should NOT see 'Pending'

Scenario: the attitudes page has a long version
Given I am on the attitudes page
  And I press 'TL;DR'
Then I should see 'Pending'

Scenario: the attitudes page allows you to use your own words
Given I am on the attitudes page
When I follow the 'cookies' link
Then I should see 'save your words'

