Feature: the natures page

Scenario: links 24 natures
Given I am on the natures page
Then all natures should be linked

Scenario: sorts by i by default
Given I am on the natures page
Then the 'i' link should be disabled

Scenario: can sort by p
Given I am on the natures page
When I follow the 'p' link
Then the 'p' link should be disabled
  But the 'i' link should NOT be disabled
