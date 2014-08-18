# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.Lister.define 'Users', ->

  clear_error_info = ->
    for div in $('div.field_errors')
      div.innerHTML = ''

    $('#login_td').removeClass('field_with_errors')
    $('#password_td').removeClass('field_with_errors')
    $('#password_conf_td').removeClass('field_with_errors')


  validate_login = ->
    login_td = $('#registration_form_wrapper #login_td')
    login = login_td.find('input#login').val()

    if (!login)
      msg = 'Пожалуйста, укажите логин'
    else
      $.ajax(
        url: '/users/check_login',
        method: 'POST',
        data: {login: login},
        async: false,
        success: (data) ->
          msg = data
      )

      if (login.length > 30)
        msg = 'Логин слишком длинный'
      else if ( !login.match(/^\w+$/) )
        msg = 'Недопустимый логин'
      else
        

    if (msg)
      login_td.addClass('field_with_errors')
      login_td.find('.field_errors').append('<p>' + msg + '</p>')
      return 1
    else 
      return 0


  validate_password = ->
    password_td = $('#registration_form_wrapper #password_td')
    password = password_td.find('input#password').val()

    if (!password)
      msg = 'Пожалуйста, укажите пароль'
    else if (password.length < 7)
      msg = 'Пароль слишком короткий'

    if (msg)
      password_td.addClass('field_with_errors')
      password_td.find('.field_errors').append('<p>' + msg + '</p>')
      return 1
    else 
      return 0


  validate_password_conf = ->
    password_conf_td = $('#registration_form_wrapper #password_conf_td')
    password = $('#registration_form_wrapper input#password').val()
    password_conf = password_conf_td.find('input#password_confirmation').val()

    if (password_conf != password)
      msg = 'Не совпадает с паролем'
      password_conf_td.addClass('field_with_errors')
      password_conf_td.find('.field_errors').append('<p>' + msg + '</p>')
      return 1
    else 
      return 0



  setup_register_form = -> 
    reg_form = $('#registration_form_wrapper form')

    reg_form.on 'submit', (e) ->
      clear_error_info()

      error_count = 0
      error_count += validate_login()
      error_count += validate_password()
      error_count += validate_password_conf()

      if (error_count > 0)
        return false



  return {
    init: ->
      setup_register_form()
  }
