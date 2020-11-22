require "secure_api/engine"

module SecureApi
  class NotInitializedError < StandardError; end
  API_ERRORS = {
    missing_field: 'User email or password is missing.',
    wrong_credentials: 'Wrong credentials, your email or password are wrong.',
    failed_logout: 'There was a problem, could not logout.',
    invalid_token: 'Access token is invalid.'
  }.freeze

  extend ActiveSupport::Autoload

  autoload :Authenticatable
  autoload :Configuration
  autoload :Encryptor
  autoload :Helpers

  class << self
    delegate(*Configuration::OPTIONS, to: :configuration)

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end

    def config_ready?
      !!(SecureApi.user_class && SecureApi.base_controller)
    end
  end
end
