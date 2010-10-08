Feature: Page
  The page offers some content compiled from markdown or not

  Scenario: The page flagged as the front page should be displayed
    Given there is an admin user
    And there is a front page "Aura home" with markdown "**TEST**"
    When I go to the home page
    Then I should see "TEST" within "strong"
    Then I should see "Aura home" within "title"

  Scenario: The page can be reached by it's slug
    Given there is a page "Aura home" with markdown "**TEST**"
    When I go to the aura-home slugged page
    Then I should see "TEST" within "strong"
    Then I should see "Aura home" within "title"
