Feature: cookies page

Scenario: the cookies page allows you to use your own word
Given I am on the cookies page
When I enter 'xyzzy' for 'F'
  And I press 'Save'
Then I should see 'xyzzy' within 'F'

Scenario: the cookies page allows you to use any save button
Given I am on the cookies page
When I enter 'xyzzy' for 'F'
  And I enter 'oops' for 'J'
  And I press 'Save'
Then I should see 'xyzzy' within 'F'
  And I should see 'oops' within 'J'

Scenario: the cookies page allows you to use your own words
Given I am on the cookies page
When I enter 'appreciative' for 'P'
  And I enter 'anxious' for 'E'
  And I press 'Save'
Then I should see 'appreciative' within 'P'
  And I should see 'anxious' within 'E'

Scenario: the cookies page allows you to bookmark your word
Given I have entered 'up' for 'J'
When I am on the cookies page
Then the link 'bookmark' should include '?J=up'

Scenario: the cookies page allows you to bookmark your words
Given I have entered 'up' for 'J'
  And I have entered 'down' for 'P'
When I am on the cookies page
Then the link 'bookmark' should include '?J=up&P=down'

Scenario: the cookies page allows you to bookmark your settings
Given I am on my page
  And I press 'Symbols'
When I am on the cookies page
Then the link 'bookmark' should include '?setting=symbols'

Scenario: the cookies page allows you to bookmark your tldr
Given I am on my page
  And I press 'More'
When I am on the cookies page
Then the link 'bookmark' should include '?details=show'

Scenario: the cookies page doesn't have a link to itself
Given I am on the cookies page
Then I should NOT see 'please use the cookies page'
  And I should NOT see 'Both'

