Feature: cycle page

Scenario: the cycle page lists the behaviors
Given I am on the cycle page
Then I should see 'Burn energy'
  And I should see 'Use strength'
  And I should see 'Get energy'
  And I should see 'Recover strength'

Scenario: the cycle page lists the attitudes
Given I am on the cycle page
Then I should see 'Energy'
  And I should see 'Strength'
  And I should see 'Mania'
  And I should see 'Depression'

Scenario: the cycle page allows you to use your own words
Given I am on the cycle page
When I follow the 'cookies' link
Then I should see 'save your words'

Scenario: the cycle page reflects cookies
Given I have entered 'up' for 'I'
When I am on the cycle page
Then I should see 'up'

Scenario: the cycle page defaults to short versions
Given I am on the cycle page
Then I should NOT see 'unbalanced'

Scenario: the cycle page has a long version
Given I am on the cycle page
  And I press 'TL;DR'
Then I should see 'unbalanced'

