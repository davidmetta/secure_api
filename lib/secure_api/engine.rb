module SecureApi
  class Engine < ::Rails::Engine
    isolate_namespace SecureApi
    config.generators.api_only = true

    initializer 'routes.secure_api', before: :load_config_initializers do
      # Mount engine routes
      Rails.application.routes.append do
        mount SecureApi::Engine, at: '/user'
      end
    end

    config.to_prepare do
      if SecureApi.config_ready?
        SecureApi.user_class.include(SecureApi::Authenticatable)
        SecureApi.base_controller.include(SecureApi::Helpers::Controller)
        ActionCable::Connection::Base.include(SecureApi::Helpers::Cable) if Object.const_defined?('ActionCable::Connection::Base')
        ActionDispatch::IntegrationTest.include(SecureApi::Helpers::Test, SecureApi) if Object.const_defined?('ActionDispatch::IntegrationTest')
        ActionCable::Connection::TestCase.include(SecureApi::Helpers::Test, SecureApi) if Object.const_defined?('ActionCable::Connection::TestCase')
      else
        message = <<-ERROR

        ### SecureApi Not Initialized ###

        The initializer must be set up to install SecureApi in your application.

        If you did not run `rails g secure_api:install` do so now, add the required configuration, and migrate your database

        ERROR
        raise NotInitializedError, message, []
      end
    end
  end
end
