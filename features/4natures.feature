Feature: the natures page

Scenario: links 24 natures
Given I am on the natures page
Then all natures should be linked

Scenario: sorts by mania by default
Given I am on the natures page
Then the 'flee & fight' link should be disabled

Scenario: can sort by p
Given I am on the natures page
When I follow the 'rest & digest' link
Then the 'rest & digest' link should be disabled
  But the 'flee & fight' link should NOT be disabled

Scenario: can get to types from natures
Given I am on the natures page
And I follow my nature
Then I should be on my nature page
