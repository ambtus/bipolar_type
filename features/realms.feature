Feature: realms page

Scenario: the realms page lists the realms
Given I am on the realms page
Then I should see 'People'
  And I should see 'Places'
  And I should see 'Things'
  And I should see 'Ideas'

Scenario: the realms page reflects cookies
Given I have entered 'social' for 'F'
When I am on the realms page
Then I should see 'Social'

Scenario: the realms page defaults to short versions
Given I am on the realms page
Then I should NOT see 'spiritual'

Scenario: the realms page has a long version
Given I am on the realms page
  And I press 'More'
Then I should see 'spiritual'

Scenario: the realms page allows you to use your own words
Given I am on the realms page
When I follow the 'cookies' link
Then I should see 'save your words'

