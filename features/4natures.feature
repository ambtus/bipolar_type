Feature: the natures page

Scenario: links 24 natures
Given I am on the natures page
Then all natures should be linked

Scenario: sorts by mania by default
Given I am on the natures page
Then the 'mania' link should be disabled

Scenario: can sort by p
Given I am on the natures page
When I follow the 'depression' link
Then the 'depression' link should be disabled
  But the 'mania' link should NOT be disabled

Scenario: can get to types from natures
Given I am on the natures page
And I follow the 'iS, Fp, eT, and Nj' link
Then I should see 'Possible Episodes'
