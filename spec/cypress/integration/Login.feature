Feature: Login
  All users should be able to login in

  Scenario: ECT login
    Given user was created as "early_career_teacher" with email "ect@example.com" and full_name "Demo User"
    And I am on "sign in" page

    When I type "nope@example.com" into "email input"
    And I click the submit button
    Then "error summary" should contain "Enter the email address your school used when they created your account"
    And the page should be accessible

    When I type "ect@example.com" into "email input"
    And I click the submit button
    Then "page heading" should contain "Welcome Demo User"
