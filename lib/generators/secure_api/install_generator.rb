require 'rails/generators'

module SecureApi
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def create_initializer
        copy_file 'initializer.rb', 'config/initializers/secure_api.rb'
      end

      def create_migration
        copy_file 'migration.rb', "db/migrate/#{Time.now.strftime('%Y%m%d%H%M%S')}_secure_api_migration.rb"
      end
    end
  end
end
