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
