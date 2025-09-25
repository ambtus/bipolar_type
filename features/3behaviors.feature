Feature: the behaviors page

Scenario: lists four realms
Given I am on the behaviors page
Then all realms should be listed

Scenario: lists four externals
Given I am on the behaviors page
Then all externals should be listed

Scenario: lists four internals
Given I am on the behaviors page
Then all internals should be listed

Scenario: lists sixteen behaviors
Given I am on the behaviors page
Then all behaviors should be listed
