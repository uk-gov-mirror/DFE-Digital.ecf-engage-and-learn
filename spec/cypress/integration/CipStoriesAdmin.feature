Feature: Admin user interaction with Core Induction Programme
  Admin users should be able to edit core induction programme years, modules,
  lessons, and lesson parts.

  Background:
    Given I am logged in as "admin"

  Scenario: Can edit years
    Given core_induction_programme was created as "with_course_year" with id "a4dc302c-ab71-4d7b-a10a-3116a778e8d5"
    And I am on "core induction programme year" page with id "a4dc302c-ab71-4d7b-a10a-3116a778e8d5"

    When I click on "link" containing "Edit year content"
    Then I should be on "core induction programme year edit" page
    And the page should be accessible
    And percy should be sent snapshot

    When I clear "title input"
    And I type "New test title" into "title input"
    And I clear "content input"
    And I type "New test content" into "content input"
    And I click on "button" containing "See preview"
    Then "page heading" should contain "preview"
    And "govspeak content" should contain "New test content"

    When I click on "button" containing "Save changes"
    Then "page body" should contain "Your changes have been saved"
    Then "page body" should contain "New test title"
    Then "page body" should contain "New test content"
    And the page should be accessible

  Scenario: Can edit modules
    Given course_module was created as "with_previous" with id "a4dc302c-ab71-4d7b-a10a-3116a778e8d5"
    And I am on "core induction programme module" page with id "a4dc302c-ab71-4d7b-a10a-3116a778e8d5"

    When I click on "link" containing "Edit module content"
    Then I should be on "core induction programme module edit" page
    And the page should be accessible
    And percy should be sent snapshot

    When I clear "title input"
    And I type "New module title" into "title input"
    And I clear "content input"
    And I type "New test module content" into "content input"
    And I click on "button" containing "See preview"
    Then "page heading" should contain "preview"
    And "govspeak content" should contain "New test module content"

    When I click on "button" containing "Save changes"
    Then "page body" should contain "Your changes have been saved"
    And "page body" should contain "New module title"
    And "page body" should contain "New test module content"
    And the page should be accessible

  Scenario: Can edit lessons
    Given course_lesson was created as "with_lesson_part" with id "a4dc302c-ab71-4d7b-a10a-3116a778e8d5"
    And I am on "core induction programme lesson" page with id "a4dc302c-ab71-4d7b-a10a-3116a778e8d5"

    When I click on "link" containing "Edit lesson"
    Then I should be on "core induction programme lesson edit" page
    And the page should be accessible
    And percy should be sent snapshot called "edit lesson page"

    When I clear "title input"
    And I type "New lesson title" into "title input"
    And I type "45" into "time input"
    And I click the submit button
    Then "page body" should contain "Your changes have been saved"
    And "page body" should contain "New lesson title"
    And "page body" should contain "Duration: 45 minutes"

    When I click on "link" containing "Edit lesson part"
    Then the page should be accessible
    And percy should be sent snapshot called "edit lesson page"

    When I clear "title input"
    And I type "Lesson part test title" into "title input"
    And I clear "content input"
    And I type "New content for lesson part" into "content input"
    And I click on "button" containing "See preview"
    Then "page heading" should contain "preview"
    And "govspeak content" should contain "New content for lesson part"

    When I click on "button" containing "Save changes"
    Then "page body" should contain "Your changes have been saved"
    And "page body" should contain "Lesson part test title"
    And "page body" should contain "New content for lesson part"
