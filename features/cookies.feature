Feature: cookies page

Scenario: the cookies page allows you to use your own words
Given I am on the cookies page
When I enter 'spiritually' for 'F'
  And I press 'Save'
Then I should see 'spiritually' within 'F'

Scenario: the cookies page allows you to bookmark your words
Given I have entered 'fix' for 'C'
When I am on the cookies page
Then the link 'bookmark' should include '?C=fix'

Scenario: the cookies page allows you to bookmark your settings
Given I am on my page
  And I press 'Words'
When I am on the cookies page
Then the link 'bookmark' should include '?setting=words'

Scenario: the cookies page allows you to bookmark your tldr
Given I am on my page
  And I press 'TL;DR'
When I am on the cookies page
Then the link 'bookmark' should include '?details=hide'
