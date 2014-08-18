require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  find(selector_for(button)).click
end

When /^(?:|I )reload the page$/ do
  visit current_url
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  expect(page).to have_content(text)
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  expect(page).not_to have_content(text)
end

Then /^(?:|I )should be on (.*)$/ do |page_name|
  current_path = URI.parse(current_url).path
  current_path.should == path_to(page_name)
end

Then /^the "([^"]*)" field should be empty$/ do |field|
  field = find(field)
  field_value = (field.tag_name == 'textarea') ? field.text : field.value
  expect(field_value).to eq ""
end

Then /^show me the page$/ do
  save_and_open_page
end

# Then /^(.*) within "([^"]*)"$/ do |step_name, parent|
#   with_scope(parent) { step step_name }
# end