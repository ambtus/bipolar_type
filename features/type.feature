Feature: type page

Scenario: my type page describes my solution
Given I am on my page
Then I should see 'pay cash' before 'sing'
  And I should see 'salary' before 'protein'

Scenario: my type page doesn't describe your solution
Given I am on my page
Then I should NOT see 'gather' before 'choose'
  And I should NOT see 'music' before 'carbs'

Scenario: your type page describes your solution
Given I am on your page
Then I should see 'gather' before 'choose'
  And I should see 'music' before 'carbs'

Scenario: your type pages doesn't describe my solution
Given I am on your page
Then I should NOT see 'salary' before 'protein'

Scenario: our pages can have similar solutions
Given I am on your page
Then I should see 'pay cash' before 'sing'
