# Be sure to restart your server when you modify this file.

#### SecureApi initalizer and configuration ####

## you can override any of these options
SecureApi.configure do |config|
  # name of the user class, defaults to User
  config.user_class = '::User'

  # base controller name
  config.base_controller = '::ApplicationController'

  # expiration of the tokens
  config.token_expires_in = 1.day

  # encryption key to encrypt tokens
  config.encryption_secret = 'd1754a7e893061fca851205982c007d3212242768e756f85c3398137d2e5c91ba0aade85d33430694575528dfad15955c06a871547ad67991d77daa9759cf9b8'

  # customize the email attribute
  config.email_attr = :custom_email_attr

  # customize the password attribute
  config.password_attr = :password
end
