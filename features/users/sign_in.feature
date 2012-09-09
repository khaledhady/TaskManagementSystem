Feature: User can sign in to the site

  Scenario: User fills in sign in fields and signs in successfully
    Given a user exists with email: "myemail@mail.com", password: "123456", password_confirmation: "123456"
    And I am on sign in page
    When I fill in "user_email" with "myemail@mail.com"
    And I fill in "user_password" with "123456"
    And I press "Sign in"
    Then I should be on my projects page