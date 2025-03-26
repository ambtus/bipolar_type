Feature: type page

Scenario: my type page describes my subtypes
Given I am on my page
Then I should see 'Physically Depressed'
  And I should see 'Socially Energetic'
  And I should see 'Financially Manic'
  And I should see 'Mentally Strong'

Scenario: my type page reflects cookies
Given I have entered 'spiritual' for 'F'
When I am on my page
Then I should see 'Spiritually Energetic'

Scenario: my type page defaults to short versions
Given I am on my page
Then I should NOT see 'Pending'

Scenario: my type page has a long version
Given I am on my page
  And I press 'TL;DR'
Then I should see 'Pending'
