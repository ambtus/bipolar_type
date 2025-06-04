Feature: type page

Scenario: my type page describes my solution
Given I am on my page
Then I should see 'listen to music'
  And I should see 'close your eyes'
  And I should see 'pay cash'
  And I should see 'lie down'

Scenario: my type page reflects cookies
Given I have entered 'sing' for 'FP'
When I am on my page
Then I should see 'sing'

Scenario: my type page defaults to short versions
Given I am on my page
Then I should NOT see 'use credit'

Scenario: my type page has a long version
Given I am on my page
  And I press 'More'
Then I should see 'use credit'
