# Be sure to restart your server when you modify this file.

#### SecureApi initalizer and configuration ####

## you can override any of these options
SecureApi.configure do |config|

  ### REQUIRED CONFIGURATION ###

  # name of the user class, defaults to User
  config.user_class = '::User'

  # base controller name
  config.base_controller = '::ApplicationController'

  # expiration of the tokens
  config.token_expires_in = 1.day

  # encryption key to encrypt tokens
  config.encryption_secret = 'YOUR_ENCRYPTION_KEY'
end
