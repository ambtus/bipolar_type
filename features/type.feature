Feature: type page

Scenario: my type page describes my subtypes
Given I am on my page
Then I should see 'physically depressed'
  And I should see 'emotionally receptive'
  And I should see 'financially manic'
  And I should see 'mentally productive'

Scenario: my type page reflects cookies
Given I have entered 'spiritual' for 'F'
When I am on my page
Then I should see 'spiritually receptive'

Scenario: my type page defaults to short versions
Given I am on my page
Then I should NOT see 'Pending'

Scenario: my type page has a long version
Given I am on my page
  And I press 'TL;DR'
Then I should see 'Pending'
