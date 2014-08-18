@javascript
Feature: user registration

  As a non-registered user
  So that I can get access to my data from any place
  I want to be able to create my user account

Background: user is currently on a home page

  Given I am on the registration page

Scenario: happy path: registering an account
  When I fill in "login" with "username"
  And I fill in "password" with "password"
  And I fill in "password_confirmation" with "password"
  And I press "register"
  Then I should be on the Lister home page
  And I should see "Пользователь Username создан успешно"
  And I should see "Username"


Scenario: sad path: login is empty
  When I try to register with "", "password"
  Then I should be on the registration page
  And I should see "Пожалуйста, укажите логин"

Scenario: sad path: login is already in use
  Given the user "username" eixsts
  When I try to register with "username", "password"
  Then I should be on the registration page
  And I should see "Логин занят"

Scenario: sad path: login contains unallowed symbols
  When I try to register with "%U$erНэйм%", "password"
  Then I should be on the registration page
  And I should see "Недопустимый логин"

Scenario: sad path: login is too long
  When I try to register with "31_symbols_here_in_that_login__", "password"
  Then I should be on the registration page
  And I should see "Логин слишком длинный"


Scenario: sad path: password is empty
  When I try to register with "Username", ""
  Then I should be on the registration page
  And I should see "Пожалуйста, укажите пароль"

Scenario: sad path: password is too short
  When I try to register with "Username", "pass"
  Then I should be on the registration page
  And I should see "Пароль слишком короткий"

Scenario: sad path: password and confirmation don't match
  When I try to register with "Username", "password", "drowssap"
  Then I should be on the registration page
  And I should see "Не совпадает с паролем"