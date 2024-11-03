Feature: cookies page

Scenario: the cookies page allows you to use your own words
Given I am on the cookies page
When I enter 'spiritual' for 'F'
  And I press 'Save'
Then I should see 'spiritual' within 'F'

Scenario: the cookies page allows you to bookmark your words
Given I have entered 'fix' for 'C'
When I am on the cookies page
Then the link 'bookmark' should include '?C=fix'

Scenario: the cookies page allows you to bookmark your settings
Given I am on my page
  And I press 'Symbols'
When I am on the cookies page
Then the link 'bookmark' should include '?setting=symbols'

Scenario: the cookies page allows you to bookmark your tldr
Given I am on my page
  And I press 'TL;DR'
When I am on the cookies page
Then the link 'bookmark' should include '?details=show'

Scenario: the cycle page hides the TL;DR by default
Given I am on the cycle page
Then I should NOT see 'entrained'

Scenario: the cycle page has a longer explanation
Given I am on the cycle page
  And I press 'TL;DR'
Then I should see 'entrained'

Scenario: the serenity page hides the TL;DR by default
Given I am on the serenity page
Then I should NOT see 'Spring mania'

Scenario: the serenity page has a longer explanation
Given I am on the serenity page
  And I press 'TL;DR'
Then I should see 'Spring mania'

Scenario: the serenity page uses cookies
Given I have entered 'reject' for 'R'
  And I have entered 'tolerate' for 'E'
When I am on the serenity page
Then I should see 'reject'
  And I should see 'tolerate'

Scenario: the serenity page doesn’t show settings form by default
Given I am on the serenity page
Then I should NOT see 'use your own words'

Scenario: the serenity pages can show setting form
Given I am on the serenity page
When I press 'TL;DR'
Then I should see 'use your own words'

