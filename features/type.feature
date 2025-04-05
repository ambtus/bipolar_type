Feature: type page

Scenario: my type page describes my solution
Given I am on my page
Then I should see 'express emotions'
  And I should see 'use logic'
  And I should see 'listen to intonation'
  And I should see 'analyze results'

Scenario: my type page reflects cookies
Given I have entered 'sing' for 'IFP'
When I am on my page
Then I should see 'sing'

Scenario: my type page defaults to short versions
Given I am on my page
Then I should NOT see 'energizing'

Scenario: my type page has a long version
Given I am on my page
  And I press 'More'
Then I should see 'energizing'
