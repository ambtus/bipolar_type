Feature: the afternoon page

Scenario: gives some personal info
Given I am on my afternoon page
Then I should see 'heavily indebted'

Scenario: has a link two realms
Given I am on my afternoon page
Then two realms should be linked

Scenario: has a link to the fifth question
Given I am on my afternoon page
When I follow the 'T' link
Then I should be on my evening page

Scenario: breadcrumbs
Given I am on my afternoon page
Then I should see the first breadcrumb
  And I should see the second breadcrumb
  And I should see the third breadcrumb
  And I should see the fourth breadcrumb
