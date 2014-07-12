# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.Lister.define 'ListItems', ->

  setup_list_items = ->

    $('.list_item_div').keydown (e) ->
      div = $(this)
      if e.which == 13 and e.ctrlKey # Enter
        e.preventDefault()
        if div.text().slice(-1) != '\n'
          div.append('\n')
        div.paste_newline()
      else if e.which == 13 and !e.ctrlKey # Ctrl+Enter
        e.preventDefault()
        div.submit_form()
        $('#new_list_item textarea').focus()
    $('.list_item_div').focusout ->
      $(this).submit_form()

  setup_input_form = ->
    form = $('#new_list_item')
    form.find('textarea').val('').autogrow().focus().keydown (e) ->
      textarea = $(this)
      if e.which == 13 and !e.ctrlKey # Enter
        e.preventDefault()
        if !textarea.val().match(/^\s*$/)
          form.submit()
        textarea.val('')
      else if e.which == 13 and e.ctrlKey # Ctrl+Enter
        textarea.val( textarea.val() + '\n' )

  return {
    init: ->
      setup_input_form()
      setup_list_items()

      # ain't good to put it here
      $(document).on 'page:update', setup_list_items
  }

$.fn.submit_form = ->
  div = $(this)
  form = div.parent()
  input = form.find('input[name="list_item\[text\]"]')
  text = div.text().replace(/&nbsp;/g, ' ')
  if !text.match(/^\s*$/)
    if text != input.val()
      input.val(text)
      form.submit()
  else
    div.text( input.val() )

$.fn.paste_newline = ->
  if (window.getSelection)
    selection = window.getSelection()
    range = selection.getRangeAt(0)
    br = document.createTextNode("\n")
    range.deleteContents();
    range.insertNode(br);
    range.setStartAfter(br);
    range.setEndAfter(br);
    range.collapse(false);
    selection.removeAllRanges();
    selection.addRange(range);