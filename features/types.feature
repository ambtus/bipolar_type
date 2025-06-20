Feature: the types page

Scenario: shows the 16 subtypes
Given I am on the types page
Then I should see Subtype actions
  And I should see Subtype episodes

Scenario: uses your words
Given I have changed the word for UEE to plugh
When I am on the types page
Then I should see plugh
  And I should NOT see the default word for UEE

Scenario: can select my type
Given I am on the types page
When I follow the link for UFS
  And I follow the link for GPE
  And I follow the link for UEE
  And I follow the link for GMS
Then I should be on my page

Scenario: can find your type
Given I am on the types page
When I follow the link for UES
  And I follow the link for GME
  And I follow the link for UFE
  And I follow the link for GPS
Then I should be on your page
