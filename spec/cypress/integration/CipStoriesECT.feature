Feature: ECT user interaction with Core Induction Programme
  Early Career Teachers should be able to access but not edit course content

  Background:
    Given I am logged in as "early_career_teacher" with id "53960d7f-1308-4de1-a56d-de03ea8e1d9c"
    And scenario "ect_cip" has been ran
    When I click on "link" containing "Go to your module materials"

  Scenario: ECT shouldn't be able to edit anything
    Then I should be on "core induction programme year" page
    And "link" containing "Edit year content" should not exist

    When I click on "link" containing "Test Course module"
    Then I should be on "core induction programme module" page
    And "link" containing "Edit module content" should not exist

    When I click on "link" containing "Test Course lesson"
    Then I should be on "core induction programme lesson part" page
    And "link" containing "Edit lesson" should not exist
    And "link" containing "Edit lesson part" should not exist

  Scenario: Displaying lesson progress
    When I click on "link" containing "Test Course module"
    Then "tag component" should contain "not started"

    When I click on "link" containing "Test Course lesson"
    And I click on "link" containing "Test Course module"
    Then "tag component" should contain "in progress"

    When I click on "link" containing "Test Course lesson"
    And I click on "There are sections that I don’t understand and would like to discuss with my mentor" label
    And I click the submit button
    Then "tag component" should contain "discussion needed"

    When I click on "link" containing "Test Course lesson"
    And I click on "I would like more time on this session and will revisit" label
    And I click the submit button
    Then "tag component" should contain "in progress"

    When I click on "link" containing "Test Course lesson"
    And I click on "I feel confident that I’ve read and understood this session" label
    And I click the submit button
    Then "tag component" should contain "complete"
