Feature: 16 subtypes page

Scenario: the subtypes page with symbols
Given I am on the subtypes page
When I press 'Symbols'
Then I should see all subtypes

Scenario: the subtypes page with words
Given I am on the subtypes page
When I press 'Words'
Then I should NOT see 'IFP'
  But I should see 'emotionally thin'

Scenario: single subtype
Given I am on the subtypes page
When I follow the 'emotionally thin' link
Then I should see 'Problem'
  And I should see 'Better Solution'

Scenario: use of generic 'things' words
Given I am on the subtypes page
  And I press 'Things'
When I follow the 'refuse too many F things' link
Then I should see 'change fewer F things'
  And I should see 'accept more F things'

Scenario: changing generic 'things' words
Given I have entered 'fix' for 'C'
  And I have entered 'take' for 'A'
  And I am on the subtypes page
  And I press 'Things'
When I follow the 'fix too many T things' link
Then I should see 'fix fewer T things'
  And I should see 'take more T things'
  And I should see 'fixing T things'
  And I should see 'taken T things'

Scenario: better grammar for compound words
Given I have entered 'do housework' for 'CS'
  And I have entered 'eat carbs' for 'AS'
When I am on the subtypes page
  And I follow the 'physically fat' link
  And I press 'Words'
Then I should see 'do more housework'
  And I should see 'eat fewer carbs'
