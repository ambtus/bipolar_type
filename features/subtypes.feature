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

Scenario: the subtypes page with things
Given I am on the subtypes page
When I press 'Things'
Then I should see 'refuse too many things'
  But I should NOT see 'IP things'

Scenario: changing generic 'things' words
Given I have entered 'fix' for 'C'
When I am on the subtypes page
  And I press 'Things'
Then I should see 'fix too many things'
  But I should NOT see 'change'

Scenario: single subtype
Given I am on the subtypes page
When I follow the 'emotionally thin' link
  And I press 'TL;DR'
Then I should see 'emotionally active'
  And I should see 'stop listening'

Scenario: use of generic 'things' words
Given I am on the subtypes page
  And I press 'Things'
When I follow the 'refuse too many F things' link
  And I press 'TL;DR'
Then I should see 'F active'
  And I should see 'stop accepting F things'

Scenario: changing generic 'things' words
Given I have entered 'fix' for 'C'
  And I have entered 'take' for 'A'
  And I am on the subtypes page
  And I press 'Things'
When I follow the 'fix too many T things' link
Then I should see 'start to fix T things'
  And I should see 'not start fixing T things'
  And I should see 'keep taking T things'
  And I should see 'more things taken'

Scenario: grammar for compound words
Given I have entered 'do housework' for 'CS'
  And I have entered 'eat carbs' for 'AS'
When I am on the subtypes page
  And I follow the 'physically fat' link
Then I should see 'doing housework'
  And I should see 'eating carbs'

Scenario: make sure last subtype works
Given I am on the subtypes page
When I follow the 'mentally weak' link
  And I press 'Things'
Then I should see 'change N things'
