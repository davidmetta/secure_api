SecureApi.configure do |config|
  config.user_class = '::User'
  config.base_controller = '::ApplicationController'
  config.token_expires_in = 1.day
  config.encryption_secret = 'd1754a7e893061fca851205982c007d3212242768e756f85c3398137d2e5c91ba0aade85d33430694575528dfad15955c06a871547ad67991d77daa9759cf9b8'
end
