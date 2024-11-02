Feature: 16 subtypes page

Scenario: the subtypes page with words
Given I am on the subtypes page
Then I should NOT see 'IFP'
  But I should see 'emotionally thin'

Scenario: the subtypes page with symbols
Given I am on the subtypes page
When I press 'Symbols'
Then I should see all subtypes

Scenario: the subtypes page with both
Given I am on the subtypes page
When I press 'Both'
Then I should see all subtypes
  And I should see 'IFP (emotionally thin)'

Scenario: use of generic 'things' words
Given I am on the subtypes page
  And I press 'Things'
When I follow the 'refuse too many F things' link
Then I should see 'refuse F things (unbalancing)'
  And I should see 'endure F things (requires sedatives)'

Scenario: single subtype
Given I am on the subtypes page
When I follow the 'emotionally thin' link
Then I should see 'Result'
  And I should see 'Better Solution'

Scenario: changing generic 'things' words
Given I have entered 'fix' for 'C'
  And I have entered 'take' for 'A'
  And I am on the subtypes page
  And I press 'Things'
When I follow the 'fix too many T things' link
Then I should see 'fix T things (unbalancing)'
  And I should see 'take T things (requires sedatives)'
  And I should see 'fixing T things'
  And I should see 'taken T things'

Scenario: better grammar for compound words
Given I have entered 'do housework' for 'CS'
  And I have entered 'eat carbs' for 'AS'
When I am on the subtypes page
  And I follow the 'physically fat' link
Then I should see 'done housework'
  And I should see 'eating carbs'

Scenario: make sure last subtype works
Given I am on the subtypes page
When I follow the 'mentally weak' link
  And I press 'Things'
Then I should see 'change N things'
