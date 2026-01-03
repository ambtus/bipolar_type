Feature: the midday page

Scenario: gives some personal info
Given I am on my midday page
Then I should see 'suicidal'

Scenario: has a link three realms
Given I am on my midday page
Then three realms should be linked

Scenario: has a link to the fourth question
Given I am on my midday page
When I follow the 'F' link
Then I should be on my afternoon page

Scenario: breadcrumbs
Given I am on my midday page
Then I should see the first breadcrumb
  And I should see the second breadcrumb
  And I should see the third breadcrumb
