Feature: the behavior page

Example: green behavior
Given I am on my type page
When I follow my first do
Then I should see 'do more'

Example: red behavior
Given I am on my type page
When I follow my first dont
Then I should see 'do less'

Example: generic behavior
Given I am on a behavior page
Then I should see 'depending'

Example: generic description
Given I am on a behavior page
Then I should see a generic description

Example: focus
Given I am on a behavior page
Then I should see a focus

Example: technical
Given I am on a behavior page
Then I should see a technical description

Example: another generic description
Given I am on another behavior page
Then I should see another generic description

Example: another focus
Given I am on another behavior page
Then I should see another focus

Example: another technical
Given I am on another behavior page
Then I should see another technical description

Example: link to behaviors from a behavior page
Given I am on a behavior page
Then I should see 'All 16 Behaviors'

Example: can get to behaviors from a behavior page
Given I am on a behavior page
When I follow the 'All 16 Behaviors' link
Then I should be on the behaviors page

Example: generics
Given I am on the behaviors page
Then I should see 'Generic Descriptions'

Example: specifics
Given I am on the behaviors page
Then I should see 'Specific Examples'


