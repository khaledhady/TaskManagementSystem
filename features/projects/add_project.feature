Feature: Admin can create a new project

  Scenario: Admin inserts data for new project to add it
    Given a user exists with email: "myemail@mail.com", password: "123456", password_confirmation: "123456", role: "admin"
    And I am on sign in page
    When I fill in "user_email" with "myemail@mail.com"
    And I fill in "user_password" with "123456"
    And I press "Sign in"
    And I press "New"
    And I fill in "project_identifier" with "ProjectIdentifier"
    And I fill in "project_name" with "ProjectName"
    And I press "Create Project"
    Then I should see "ProjectIdentifier"

  Scenario: Admin creates a sub project for a certain project
    Given a user exists with email: "myemail@mail.com", password: "123456", password_confirmation: "123456", role: "admin", id: 1
    And user "myemail@mail.com" manages "5" projects
    And I am on sign in page
    When I fill in "user_email" with "myemail@mail.com"
    And I fill in "user_password" with "123456"
    And I press "Sign in"
    And I press "Show"
    And I press "Create Sub Project"
    And I fill in "project_identifier" with "SubProjectIdentifier"
    And I fill in "project_name" with "SubProjectName"
    And I press "Create Project"
    Then I should see "SubProjectIdentifier"
