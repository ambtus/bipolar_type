Feature: the ep page

Scenario: has a link three realms
Given I am on my ep page
Then three realms should be linked

Scenario: has a link to the fourth question
Given I am on my ep page
When I follow the 'eFp' link
Then I should be on my ej page

Scenario: breadcrumbs
Given I am on my ep page
Then I should see the first breadcrumb
  And I should see the second breadcrumb
  And I should see the third breadcrumb
