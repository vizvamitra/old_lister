Given(/^the user "([^"]*)" eixsts$/) do |name|
  User.create(login: name, password: "password", password_confirmation: "password")
end

When(/^(?:|I )try to register with "([^"]*)", "([^"]*)"(?:, "([^"]*)")?$/) do |name, pass, confirm|
  step %Q{I fill in "login" with "#{name}"}
  step %Q{I fill in "password" with "#{pass}"}
  step %Q{I fill in "password_confirmation" with "#{confirm || pass}"}
  step 'I press "register"'
end
