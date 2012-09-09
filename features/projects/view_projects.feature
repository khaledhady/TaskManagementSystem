Feature: User views his / her projects

  Scenario: Admin sees a list of only the projects he is admin of
    Given a user exists with email: "myemail@mail.com", password: "123456", password_confirmation: "123456", role: "admin"
    And Given the following projects exist
      | name       | identifier |
      | MyProject1 | project1   |
      | MyProject2 | project2   |
      | MyProject3 | project3   |
    When I go to path "/products"
    Then I should see products table
      | Milk   | $2.99 |
      | Puzzle | $8.99 |
    And I am on sign in page
    When I fill in "user_email" with "myemail@mail.com"
    And I fill in "user_password" with "123456"
    And I press "Sign in"
    And 
    And I press "New"
    And I fill in "project_identifier" with "ProjectIdentifier"
    And I fill in "project_name" with "ProjectName"
    And I press "Create Project"
    Then I should see "ProjectIdentifier"