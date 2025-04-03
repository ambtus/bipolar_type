Feature: questions page

Scenario: the questions page allows you to use your own words
Given I am on the questions page
When I follow the 'cookies' link
Then I should see 'save your words'

Scenario: the questions page allows you to choose an option
Given I am on the questions page
When I follow the 'expressive' link
Then I should see 'Question #2 of 3'

Scenario: choosing an option restricts the possibilities to 16 subtypes
Given I am on the questions page
Then there should be 16 answer links

Scenario: choosing an option restricts the possibilities to 9 + you
Given I am on the questions page
When I follow the 'expressive' link
Then there should be 10 answer links

Scenario: choosing two options restricts the possibilities to 4 + you
Given I am on the questions page
When I follow the 'expressive' link
  And I follow the 'deductive' link
Then there should be 5 answer links

Scenario: the questions page allows you to get to my page
Given I am on the questions page
When I follow the 'expressive' link
  And I follow the 'physical depression' link
  And I follow the 'deductive' link
Then I should be on my page
  And the 'Me' link should be disabled

Scenario: the questions page doesnt always get to my page
Given I am on the questions page
When I follow the 'expressive' link
  And I follow the 'physical depression' link
  And I follow the 'mental mania' link
Then I should NOT be on my page
  And the 'Me' link should NOT be disabled

Scenario: the questions page uses your words
Given I have entered 'musical' for 'FP'
  And I have entered 'material' for 'T'
  And I have entered 'anger' for 'I'
  And I have entered 'logical' for 'NJ'
  And I am on the questions page
When I follow the 'musical' link
  And I follow the 'material anger' link
  And I follow the 'logical' link
Then I should be on my page

Scenario: the questions page shows all subtypes
Given I am on the questions page
  And I press 'Symbols'
Then I should see all subtypes

