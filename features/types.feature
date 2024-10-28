Feature: 24 types page

Scenario: the types page with symbols
Given I am on the types page
When I press 'Symbols'
Then I should NOT see 'emotionally thin'
  But I should see 'IFP'

Scenario: the types page with words
Given I am on the types page
When I press 'Words'
Then I should NOT see 'IFP'
  But I should see 'emotionally thin'

Scenario: the types page with generic 'things'
Given I am on the types page
When I press 'Things'
Then I should NOT see 'IFP'
  And I should NOT see 'emotionally thin'
  But I should see 'refuse too many F things'

Scenario: the types page with different words
Given I have entered 'anorexic' for 'IP'
  And I have entered 'spiritually' for 'F'
  And I am on the types page
Then I should NOT see 'emotionally thin'
  But I should see 'spiritually anorexic'

Scenario: the types page with different words
Given I have entered 'fix' for 'C'
  And I have entered 'reject' for 'R'
  And I am on the types page
Then the 'fix' link should be disabled
  But the 'reject' link should NOT be disabled
  And I should NOT see 'change'

Scenario: the types page after sorting
Given I am on the types page
And I follow the 'accept' link
Then the 'accept' link should be disabled
  But the 'change' link should NOT be disabled
  And I should see 'emotionally thin' before 'emotionally strong'

Scenario: the types page footer with different words
Given I have entered 'obese' for 'EP'
  And I am on the types page
Then I should see 'will rarely be physically obese'
  And I should NOT see 'fat'

Scenario: get to my type
Given I am on the types page
When I follow the '15' link
Then I should be on my page
