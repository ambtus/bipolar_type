Feature: type page

Scenario: my type page describes my solution
Given I am on my page
Then I should see 'pay cash' before 'emote'
  And I should see 'protein' before 'salary'

Scenario: my type page doesn't describe your solution
Given I am on my page
Then I should NOT see 'travel' before 'guess'
  And I should NOT see 'carbs' before 'music'

Scenario: your type page describes your solution
Given I am on your page
Then I should see 'travel' before 'guess'
  And I should see 'carbs' before 'music'

Scenario: your type pages doesn't describe my solution
Given I am on your page
Then I should NOT see 'protein' before 'salary'

Scenario: our pages can have similar solutions
Given I am on your page
Then I should see 'pay cash' before 'emote'
