Feature: type page

Scenario: my type page describes my tendencies
Given I am on my page
Then I should see 'physically fat'
  And I should see 'emotionally thin'
  And I should see 'financially strong'
  And I should see 'mentally weak'

Scenario: my type page reflects cookies
Given I have entered 'spiritually' for 'F'
When I am on my page
Then I should see 'spiritually thin'

Scenario: my type page says i should listen more and eat less
Given I am on my page
Then I should see 'do not eat'
  And I should see 'listen'

Scenario: my type page reflects cookies
Given I have entered 'turn on the radio' for 'FA'
When I am on my page
Then I should see 'turn on the radio'
  But I should NOT see 'listen'

Scenario: my type page says the best time to listen is in the evening
Given I am on my page
When I press 'TL;DR'
Then I should see 'Evening' before '1: listen'
