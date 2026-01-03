Feature: the morning page

Scenario: gives some personal info
Given I am on my morning page
Then I should see 'binge'

Scenario: has a link to realms
Given I am on my morning page
Then all realms should be linked

Scenario: has a link to the third question
Given I am on my morning page
When I follow the 'T' link
Then I should be on the midday page

Scenario: breadcrumbs
Given I am on my morning page
Then I should see the first breadcrumb
  And I should see the second breadcrumb
