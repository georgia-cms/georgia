class Login < SitePrism::Page

  set_url '/admin/login'

  element :email_field, "input#user_email"
  element :password_field, "input#user_password"
  element :submit_button, "input[name='commit']"

  element :error_message, '.alert'

end