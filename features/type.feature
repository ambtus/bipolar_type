Feature: the type page

Scenario: for my type describes my solution
Given I am on my page
Then I should see 'cash' before 'sing'
  And I should see 'salary' before 'protein'

Scenario: for my type doesn't describe your solution
Given I am on my page
Then I should NOT see 'gather' before 'choose'
  And I should NOT see 'music' before 'carbs'

Scenario: for your type describes your solution
Given I am on your page
Then I should see 'gather' before 'choose'
  And I should see 'music' before 'carbs'

Scenario: for your type doesn't describe my solution
Given I am on your page
Then I should NOT see 'salary' before 'protein'

Scenario: for our types can have similar solutions
Given I am on your page
Then I should see 'cash' before 'sing'

Scenario: can show just one realm at a time
Given I am on my page
When I follow the 'People' link
Then I should see 'sing'
  But I should NOT see 'pay cash'
  And the 'People' link should be disabled
  And the 'All' link should NOT be disabled

Scenario: can get back to all four
Given I am on my page
When I follow the 'People' link
  And I follow the 'All' link
Then I should see 'pay cash'
  And the 'People' link should NOT be disabled
  But the 'All' link should be disabled

