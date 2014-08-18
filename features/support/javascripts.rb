module JavascriptHelpers
  def edit_list_item_script(inner_text, new_text)
    "$('div.list_item_div:contains(\"#{inner_text}\")').text('#{new_text}').trigger('focusout');"
  end

  def click_control_button_script(inner_text, button)
    button_class = case button
      when 'done' then 'check'
      when 'delete' then 'cross'
    end

    "$('li:contains(\"#{inner_text}\")').find('a.#{button_class}').click();"
  end
end

World(JavascriptHelpers)