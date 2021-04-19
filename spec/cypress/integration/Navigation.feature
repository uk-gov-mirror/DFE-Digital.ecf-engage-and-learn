Feature: Navigation
  What page navigation should display and do

  Scenario: Service name should point at start page when user is not logged in
    Given I am on "start" page
    When I click on "service name in navigation"
    Then I should be on "start" page

  Scenario: Service name should point at start page when user is in login flow
    Given I am on "start" page
    And I click on "link" containing "Start"
    When I click on "service name in navigation"
    Then I should be on "start" page

  Scenario: Service name should point at start page when user is in create account flow
    Given I am logged in as "early_career_teacher" with account_created "false"
    When I click on "service name in navigation"
    Then I should be on "start" page

  Scenario: Service name should point at dashboard when user is logged in
    Given I am logged in as "early_career_teacher"
    When I click on "service name in navigation"
    Then I should be on "dashboard" page

  Scenario: Navigation items should not be displayed when user is not logged in
    Given I am on "start" page
    Then "service navigation item" should not exist

  Scenario: Navigation items should not be displayed when user is in login flow
    Given I am on "start" page
    And I click on "link" containing "Start"
    Then "service navigation item" should not exist

  Scenario: Navigation items should not be displayed when user is in create account flow
    Given I am logged in as "early_career_teacher" with account_created "false"
    Then "service navigation item" should not exist

  Scenario: Navigation should show "Home" and "Sign out" elements when user is signed in
    Given I am logged in as "early_career_teacher"
    Then "service navigation item" containing "Home" should exist
    Then "service navigation item" containing "Sign out" should exist

  Scenario: Navigation should show "Home", "Sign out" and "Core Induction Programme" elements when user is signed in as admin
    Given I am logged in as "admin"
    Then "service navigation item" containing "Home" should exist
    Then "service navigation item" containing "Sign out" should exist
    Then "service navigation item" containing "Core Induction Programme" should exist
