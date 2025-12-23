Feature: the concept pages

Scenario: links to realms work
Given I am on the concepts page
When I follow realms
Then all links should work

Scenario: links to moods work
Given I am on the concepts page
When I follow moods
Then all links should work

Scenario: links to subtypes work
Given I am on the concepts page
When I follow subtypes
Then all links should work

Scenario: links to actions work
Given I am on the concepts page
When I follow actions
Then all links should work

Scenario: links to behaviors work
Given I am on the concepts page
When I follow behaviors
Then all links should work

Scenario: links to natures work
Given I am on the concepts page
When I follow natures
Then all links should work

Example: old natures give alert
When I am on a bad nature page
Then I should see an alert
And I should be on the natures page
