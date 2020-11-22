require 'rails/generators'

module SecureApi
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def create_initializer
        template 'initializer.rb', 'config/initializers/secure_api.rb'
      end

      def create_migration
        migration_template 'migration.rb', 'db/migrate/secure_api_migration..rb'
      end
    end
  end
end
