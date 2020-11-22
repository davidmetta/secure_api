require "secure_api/engine"

module SecureApi
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

  mattr_accessor :user_class, :base_controller

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end

    def user_class
      configuration.user_class.constantize
    end

    def base_controller
      configuration.base_controller.constantize
    end

    def encryption_secret
      configuration.encryption_secret
    end
  end
end
