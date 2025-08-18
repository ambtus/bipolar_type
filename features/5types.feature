Feature: the types pages

Example: has 16 subtypes
Given I am on the types page
Then all behaviors should be linked

Scenario: can select my type
Given I am on the types page
When I follow my links
Then I should be on my page

Scenario: can find your type
Given I am on the types page
When I follow your links
Then I should be on your page

Scenario: can find types by either-or questions
Given I am on the types page
When I follow the 'questions' link
Then my advice should be visible

Scenario: lets you try something else
Given I am on the types page
When I follow the 'questions' link
  And I click the button
Then I should see try

Scenario: can find types by either-or questions
Given I am on the types page
When I follow the 'questions' link
  And I click the button
  And I follow the '3rd alternate' link
Then my advice should NOT be visible

Scenario: has six lines for all behaviors
Given I am on the types page
When I follow the 'questions' link
  And I click the button
  And I follow the '5th alternate' link
Then I should NOT see Q
