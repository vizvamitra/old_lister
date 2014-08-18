@javascript
Feature: login and logout
  
  As a registered user
  So that I can access my data
  I want to be able to log in and out

Background: user "username" eixsts in database
  Given the user "username" eixsts

Scenario: logging out
  Given I am logged in as a 'username'
  And I am on the registration page
  When I press 'log out'
  Then I should be on the registration page
  And I should not see 'Username'

Scenario: happy path: successfully logging in 
  Given I am on the registration page
  When I fill in 'login' with 'username' and 'password' with 'password'
  And I press 'log in'
  Then I should be on the registration page
  And I should see 'Username'

Scenario: sad path: incorrect login
  Given I am on the registration page
  When I fill in 'login' with 'not_a_user' and 'password' with 'password'
  And I press 'log in'
  Then I should be on the registration page
  And I should see "Неверная пара логин/пароль"

Scenario: sad path: incorrect password
  Given I am on the registration page
  When I fill in 'login' with 'username' and 'password' with 'incorrect_pass'
  And I press 'log in'
  Then I should be on the registration page
  And I should see "Неверная пара логин/пароль"