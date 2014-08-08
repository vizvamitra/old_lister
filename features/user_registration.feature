Feature: user registration

  As a non-registered user
  So that I can get access to my data from any place
  I want to be able to create my user account

Background: user is currently on a home page

  Given I am on the Lister home page

Scenario: happy path: registering an account
  When I press "start_registration"
  And I fill in "login" with "username"
  And I fill in "password" with "password"
  And I fill in "password_confirmation" with "password"
  And I press "register"
  Then I should see "Пользователь создан успешно"
  And I should see "Username"


Scenario: sad path: login is already in use
  Given the user "username" eixsts
  When I try to register with "Username", "password"
  Then I should see "Логин занят"

Scenario: sad path: login contains unallowed symbols
  When I try to register with "%U$erНэйм%", "password"
  Then I should see "Разрешены только символы a-z, 0-9, _"

Scenario: sad path: login is too short
  When I try to register with "Me", "password"
  Then I should see "Минимум 3 символа"

Scenario: sad path: login is too long
  When I try to register with "21_symbols_name_here_", "password"
  Then I should see "Максимум 20 символов"


Scenario: sad path: password is too short
  When I try to register with "Username", "pass"
  Then I should see "Минимум 6 символов"

Scenario: sad path: password and confirmation don't match
  When I try to register with "Username", "password", "drowssap"
  Then I should see "Пароли не совпадают"