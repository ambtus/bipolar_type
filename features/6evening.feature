Feature: the ij page

Scenario: has a link one realm
Given I am on my ij page
Then one realm should be linked

Scenario: has a link to the fifth question
Given I am on my ij page
When I follow the 'N' link
Then I should be on my type page

Scenario: breadcrumbs
Given I am on my ij page
Then I should see the first breadcrumb
  And I should see the second breadcrumb
  And I should see the third breadcrumb
  And I should see the fourth breadcrumb
  And I should see the fifth breadcrumb
