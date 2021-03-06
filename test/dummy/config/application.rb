require_relative 'boot'

# require 'rails/all'

require 'active_record/railtie'
# require 'active_storage/engine'
require 'action_controller/railtie'
# require 'action_view/railtie'
# require 'action_mailer/railtie'
# require 'active_job/railtie'
require 'action_cable/engine'
# require 'action_mailbox/engine'
# require 'action_text/engine'
require 'rails/test_unit/railtie'
# require 'sprockets/railtie'

Bundler.require(*Rails.groups)
require "secure_api"

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.paths['config/database'] = [ENV.fetch("DEPLOYMENT_DATABASE_PATH", 'config/database.yml')]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
