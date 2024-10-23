Feature: type page

Scenario: my type page says i am spiritually thin
Given I am on my page
Then I should see 'Tendencies emotionally thin'

Scenario: my type page reflects cookies
Given I have entered 'spiritually' for 'F'
When I am on my page
Then I should see 'Tendencies spiritually thin'

Scenario: my type page says i should listen more
Given I am on my page
Then I should see 'Goals listen'

Scenario: my type page reflects cookies
Given I have entered 'turn on the radio' for 'FA'
When I am on my page
Then I should see 'Goals turn on the radio'

Scenario: my type page says the best time to listen is in the evening
Given I am on my page
Then I should see 'Evening listen'
