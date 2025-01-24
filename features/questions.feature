Feature: questions page

Scenario: the questions page allows you to use your own words
Given I am on the questions page
When I follow the 'cookies' link
Then I should see 'save your words'

Scenario: the questions page allows you to choose an option
Given I am on the questions page
When I follow the 'emotionally receptive' link
Then I should see 'Question #2 of 3'

Scenario: the questions page allows you to get to my page
Given I am on the questions page
When I follow the 'emotionally receptive' link
  And I follow the 'physically depressed' link
  And I follow the 'mentally productive' link
Then I should be on my page
  And the 'Me' link should be disabled

Scenario: the questions page doesnt always get to my page
Given I am on the questions page
When I follow the 'emotionally receptive' link
  And I follow the 'physically depressed' link
  And I follow the 'mentally manic' link
Then I should NOT be on my page
  And the 'Me' link should NOT be disabled

Scenario: the questions page uses your words
Given I have entered 'spiritual' for 'F'
  And I have entered 'material' for 'T'
  And I have entered 'angry' for 'M'
  And I have entered 'powerful' for 'J'
  And I am on the questions page
When I follow the 'spiritually receptive' link
  And I follow the 'materially angry' link
  And I follow the 'mentally powerful' link
Then I should be on my page

Scenario: the questions page shows all subtypes
Given I am on the questions page
  And I press 'Symbols'
Then I should see all subtypes

Scenario: answering one question makes it and its siblings disappear
Given I am on the questions page
  And I press 'Symbols'
When I follow the 'FP' link
Then I should NOT see 'FP'
  And I should NOT see 'FJ'
  And I should NOT see 'SP'
  But I should see 'SJ'
