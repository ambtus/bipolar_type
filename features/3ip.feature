Feature: the ip page

Scenario: has a link to realms
Given I am on my ip page
Then all realms should be linked

Scenario: has a link to the third question
Given I am on my ip page
When I follow the 'iSp' link
Then I should be on the ep page

Scenario: breadcrumbs
Given I am on my ip page
Then I should see the first breadcrumb
  And I should see the second breadcrumb
