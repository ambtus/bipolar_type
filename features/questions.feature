Feature: questions page

Scenario: the questions page allows you to use your own words
Given I am on the questions page
When I follow the 'cookies' link
Then I should see 'save your words'

Scenario: the questions page allows you to choose an option
Given I am on the questions page
When I follow the 'communicate' link
Then I should see 'Question #2 of 3'

Scenario: the questions page allows you to get to my page
Given I am on the questions page
When I follow the 'purchase' link
  And I follow the 'eat & digest' link
  And I follow the 'logical' link
Then I should be on my page
  And the 'Me' link should be disabled

Scenario: the questions page doesnt always get to my page
Given I am on the questions page
When I follow the 'purchase' link
  And I follow the 'eat & digest' link
  And I follow the 'moral' link
Then I should NOT be on my page
  And the 'Me' link should NOT be disabled

Scenario: the questions page uses your words
Given I have entered 'musical' for 'FP'
  And I have entered 'material' for 'IT'
  And I have entered 'fat' for 'ES'
  And I am on the questions page
When I follow the 'fat' link
  And I follow the 'material' link
  And I follow the 'musical' link
Then I should be on my page

Scenario: the questions page shows ei subtypes
Given I am on the questions page
  And I press 'Symbols'
Then I should see ei subtypes

Scenario: answering one question makes it and its siblings disappear
Given I am on the questions page
  And I press 'Symbols'
When I follow the 'EF' link
Then I should NOT see 'EF'
  And I should NOT see 'ES'
  And I should NOT see 'EN'
  And I should NOT see 'ET'
  And I should NOT see 'IF'
  But I should see 'IN'
  And I should see 'IS'
  And I should see 'IT'
