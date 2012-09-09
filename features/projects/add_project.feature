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

  @javascript
  Scenario: Admin creates a sub project for a cetain project
    Given a user exists with email: "myemail@mail.com", password: "123456", password_confirmation: "123456", role: "admin"
    Given a project exists with identifier: "ProjectIdentifier", name: "ProjectName"
    And I am on sign in page
    When I fill in "user_email" with "myemail@mail.com"
    And I fill in "user_password" with "123456"
    And I press "Sign in"
    And I press "Show"
    And I press "Create Sub Project"
    And I fill in "project_identifier" with "Sub-ProjectIdentifier"
    And I fill in "project_name" with "Sub-ProjectName"
    And I press "Create Project"
    Then I should see "Sub-ProjectIdentifier"
