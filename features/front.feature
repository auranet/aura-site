Feature: Front page
  The front page offers some content and a news listing

  Scenario: The first user can sign up as an admin
    When I go to the home page
    Then I should see "please provide the details of the site administrator"
    When I fill in "user_name" with "New User"
    And I fill in "user_email_address" with "test@example.com"
    And I fill in "user_password" with "s3cRe7"
    And I fill in "user_password_confirmation" with "s3cRe7"
    And I press "Signup"
    Then I should see "Thanks for signing up!"
    And I should see "Logged in as New User"
    When I follow "Logged in as New User"
    Then I should see "Administrator"
    When I follow "Edit User"
    Then the "#user_administrator" checkbox should be checked
