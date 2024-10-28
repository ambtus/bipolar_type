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
Then I should see 'Role'
  And I should see 'Actual Problem'
