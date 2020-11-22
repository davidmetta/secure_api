module SecureApi
  class Engine < ::Rails::Engine
    isolate_namespace SecureApi
    config.generators.api_only = true

    initializer 'migration.secure_ap', before: :load_config_initializers do
      # Includes engine migration when doing db:migrate
      # config.paths["db/migrate"].expanded.each do |expanded_path|
      #   Rails.application.config.paths["db/migrate"] << expanded_path
      # end

      # Mount engine routes
      # Rails.application.routes.append do
      #   mount SecureApi::Engine, at: '/user'
      # end
    end

    # Include basic helpers where needed
    config.to_prepare do
      SecureApi.user_class.include SecureApi::Authenticatable
      SecureApi.base_controller.include SecureApi::Helpers::Controller
      ActionCable::Connection::Base.include SecureApi::Helpers::Cable
      ActionDispatch::IntegrationTest.include SecureApi::Helpers::Test, SecureApi
      ActionCable::Connection::TestCase.include SecureApi::Helpers::Test, SecureApi
    end
  end
end
