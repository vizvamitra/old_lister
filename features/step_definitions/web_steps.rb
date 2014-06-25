require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )press "([^"]*)" key$/ do |key|
  script = <<-EOS
    var event = jQuery.Event("keypress");
    event.ctrlKey = false;
    event.which = 43; // enter
    $(':focus').trigger(event);
  EOS

  case key

  when "enter" then page.execute_script(script)

  else
    begin
      page_name =~ /^the (.*) page$/
      path_components = $1.split(/\s+/)
      self.send(path_components.push('path').join('_').to_sym)
    rescue NoMethodError, ArgumentError
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end