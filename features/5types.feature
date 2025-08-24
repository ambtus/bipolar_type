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

Scenario: lets you try something else
Given I am on the questions page
Then my advice should be visible

Scenario: lets you try something else
Given I am on the questions page
When I click the button
Then I should see Pairwise

Scenario: can find types by either-or questions
Given I am on the questions page
When I click the button
  And I follow the '2nd alternate' link
Then my advice should NOT be visible

Scenario: has six lines for all behaviors
Given I am on the questions page
When I click the button
  And I follow the '6th alternate' link
Then I should NOT see Q

Scenario: can get some hints from mbti pairs
Given I am on the questions page
When I click the button
  And I follow the 'TFP/NSJ' link
Then my advice should be visible

Scenario: can get different hints from different mbti pairs
Given I am on the questions page
When I click the button
  And I follow the 'NSP/TFJ' link
Then my advice should NOT be visible

Scenario: can get to my type from mbti pairs
Given I am on the questions page
When I click the button
  And I follow the 'TFP/NSJ' link
  And I follow the 'ifp-etp-enj-isj' link
  And I follow my path
Then I should be on my page
