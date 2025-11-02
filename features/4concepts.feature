Feature: the concept pages

Scenario: links to realms work
Given I am on the theory page
When I follow realms
Then all links should work

Scenario: links to moods work
Given I am on the theory page
When I follow moods
Then all links should work

Scenario: links to subtypes work
Given I am on the theory page
When I follow subtypes
Then all links should work

Scenario: links to attitudes work
Given I am on the theory page
When I follow attitudes
Then all links should work

Scenario: links to behaviors work
Given I am on the theory page
When I follow behaviors
Then all links should work
