module ListItemsHelper

  def list_item_div(list_item)
    classes = ['list_item_div']
    attributes = ["spellcheck='false'"]
    
    if list_item.done?
      classes << 'done'
    else
      attributes << "contenteditable='true'"
    end

    "<div class='#{classes.join(' ')}' #{attributes.join(' ')}>#{list_item.text}</div>"
  end
  
end
