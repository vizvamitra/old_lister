require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "javascripts"))

Given(/^list item "(.*?)" exists$/) do |text|
  ListItem.create(text: text)
end

Given /^"([^"]*)" list item is done$/ do |item_text|
  ListItem.find_by(text: item_text).update(done: true)
end

When /^(?:|I )click on a "([^"]*)" list item$/ do |text|
  page.find("div.list_item_div", text: text).click
end

When(/^(?:|I )add "([^"]*)" to "([^"]*)" list item$/) do |text_to_add, item_text|
  new_text = item_text + text_to_add
  page.evaluate_script( edit_list_item_script(item_text, new_text) )
end

When(/^(?:I )press "([^"]*)" button of "([^"]*)" list item$/) do |button, item_text|
  page.evaluate_script( click_control_button_script(item_text, button) )
end

Then(/^"([^"]*)" list item should (|not )be marked done$/) do |item_text, not_done|
  classes = page.find('.list_item_div', text: item_text)['class']
  if not_done.empty?
    expect(classes).to include("done")
  else
    expect(classes).not_to include("done")
  end
end