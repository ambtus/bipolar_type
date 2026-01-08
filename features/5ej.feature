Feature: the ej page

Scenario: has a link two realms
Given I am on my ej page
Then two realms should be linked

Scenario: has a link to the fifth question
Given I am on my ej page
When I follow the 'eTj' link
Then I should be on my ij page

Scenario: breadcrumbs
Given I am on my ej page
Then I should see the first breadcrumb
  And I should see the second breadcrumb
  And I should see the third breadcrumb
  And I should see the fourth breadcrumb
