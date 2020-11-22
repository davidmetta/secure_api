module SecureApi
  module Helpers
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Cable
      autoload :Controller
      autoload :Test
    end
  end
end
