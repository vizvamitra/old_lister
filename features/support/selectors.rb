module HtmlSelectorsHelpers

  def selector_for(locator)
    case locator

    when "list items" then "#list_items"
    when "add" then "#add_button_wrapper input"
    when "done" then ".check"
    when "delete" then ".cross"
    when "start_registration" then "#start_registration"
    when 'login' then '#new_user #login'
    when 'password' then '#new_user #password'
    when 'password_confirmation' then '#new_user #password_confirmation'
    when 'register' then '#new_user #register'
    when 'back' then '#back'

    when /^"([^"]+)"$/
      $1

    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelpers)