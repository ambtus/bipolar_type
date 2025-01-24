Feature: realms page

Scenario: the realms page lists the attitudes
Given I am on the realms page
Then I should see 'Emotional'
  And I should see 'Physical'
  And I should see 'Mental'
  And I should see 'Financial'

Scenario: the realms page reflects cookies
Given I have entered 'spiritual' for 'F'
When I am on the realms page
Then I should see 'Spiritual'

Scenario: the realms page defaults to short versions
Given I am on the realms page
Then I should NOT see 'Pending'

Scenario: the realms page has a long version
Given I am on the realms page
  And I press 'TL;DR'
Then I should see 'Pending'

