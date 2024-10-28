Feature: questions page

Scenario: the questions page allows you to use your own words
Given I am on the questions page
When I follow the 'cookies' link
Then I should see 'save your words'

Scenario: the questions page allows you to choose an option
Given I am on the questions page
When I follow the 'emotionally thin' link
Then I should see 'Question #2 of 3'

Scenario: the questions page allows you to get to my page
Given I am on the questions page
When I follow the 'emotionally thin' link
  And I follow the 'physically fat' link
  And I follow the 'mentally weak' link
Then I should be on my page
  And the 'Me' link should be disabled

Scenario: the questions page doesnt always get to my page
Given I am on the questions page
When I follow the 'emotionally thin' link
  And I follow the 'physically fat' link
  And I follow the 'mentally strong' link
Then I should NOT be on my page
  And the 'Me' link should NOT be disabled

Scenario: the questions page uses your words
Given I have entered 'spiritually' for 'F'
  And I have entered 'materially' for 'T'
  And I have entered 'dominant' for 'IJ'
  And I have entered 'submissive' for 'EJ'
  And I am on the questions page
When I follow the 'spiritually thin' link
  And I follow the 'materially dominant' link
  And I follow the 'mentally submissive' link
Then I should be on my page

Scenario: the questions page shows all subtypes
Given I am on the questions page
Then I should see all subtypes

Scenario: answering one question makes it and its siblings disappear
Given I am on the questions page
When I follow the 'IFP' link
Then I should NOT see 'IFP'
  And I should NOT see 'IFJ'
  And I should NOT see 'ISP'
  But I should see 'ISJ'
