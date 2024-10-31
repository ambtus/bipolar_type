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
  And I press 'Words'
Then I should see 'don’t eat'
  And I should see 'do listen'

Scenario: my type page uses compound words correctly
Given I have entered 'turn on the radio' for 'AF'
When I am on my page
  And I press 'Words'
  And I press 'TL;DR'
Then I should see 'do turn on the radio'
  And I should see 'You must turn on the radio'
  But I should NOT see 'listen'

Scenario: my type page defaults to short versions
Given I am on my page
When I press 'Words'
Then I should see 'Evening: do listen'

