Feature: questions page

Scenario: the questions page allows you to use your own words
Given I am on the questions page
When I follow the 'cookies' link
Then I should see 'save your words'

Scenario: the questions page allows you to choose an option
Given I am on the questions page
When I follow the 'spiritual energy' link
Then I should see 'Question #2 of 3'

Scenario: the questions page allows you to get to my page
Given I am on the questions page
When I follow the 'spiritual energy' link
  And I follow the 'physical depression' link
  And I follow the 'mental strength' link
Then I should be on my page
  And the 'Me' link should be disabled

Scenario: the questions page doesnt always get to my page
Given I am on the questions page
When I follow the 'spiritual energy' link
  And I follow the 'physical depression' link
  And I follow the 'mental mania' link
Then I should NOT be on my page
  And the 'Me' link should NOT be disabled

Scenario: the questions page uses your words
Given I have entered 'social' for 'F'
  And I have entered 'material' for 'T'
  And I have entered 'anger' for 'I'
  And I have entered 'powerful' for 'J'
  And I am on the questions page
When I follow the 'social energy' link
  And I follow the 'material anger' link
  And I follow the 'mental powerful' link
Then I should be on my page

Scenario: the questions page shows all subtypes
Given I am on the questions page
  And I press 'Symbols'
  And I press 'More'
Then I should see all subtypes

Scenario: answering one question makes it and its siblings disappear
Given I am on the questions page
  And I press 'Symbols'
  And I press 'More'
When I follow the 'F P' link
Then I should NOT see 'FP'
  And I should NOT see 'IF'
  And I should NOT see 'EF'
  And I should NOT see 'SP'
  But I should see 'SJ'
  And I should see 'IS'
  And I should see 'ES'
