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

    # Include basic helpers where needed
    config.to_prepare do
      SecureApi.user_class.include(SecureApi::Authenticatable) if defined?(SecureApi.user_class)
      SecureApi.base_controller.include(SecureApi::Helpers::Controller) if defined?(SecureApi.base_controller)
      ActionCable::Connection::Base.include(SecureApi::Helpers::Cable) if defined?(ActionCable::Connection::Base)
      ActionDispatch::IntegrationTest.include(SecureApi::Helpers::Test, SecureApi) if defined?(ActionDispatch::IntegrationTest)
      ActionCable::Connection::TestCase.include(SecureApi::Helpers::Test, SecureApi) if defined?(ActionCable::Connection::TestCase)
    end
  end
end
