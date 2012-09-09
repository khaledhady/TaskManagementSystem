Feature: Admin can add a user to the system

  Scenario: Admin inserts data for new user to add him/her
    Given a user exists with email: "myemail@mail.com", password: "123456", password_confirmation: "123456", role: "admin"
    And I am on sign in page
    When I fill in "user_email" with "myemail@mail.com"
    And I fill in "user_password" with "123456"
    And I press "Sign in"
    And I press "Manage Users"
    And I press "New"
    When I fill in "user_email" with "member@mail.com"
    And I fill in "user_password" with "123456"
    And I fill in "user_password_confirmation" with "123456"
    And I fill in "user_role" with "member"
    And I fill in "user_name" with "NewMember"
    And I press "Save User"
    Then I should see "NewMember"
