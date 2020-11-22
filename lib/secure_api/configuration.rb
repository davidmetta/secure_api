module SecureApi
  class Configuration
    OPTIONS = %i[user_class base_controller token_expires_in encryption_secret].freeze

    attr_accessor(*OPTIONS)

    def user_class
      (@user_class || '::User').constantize
    end

    def base_controller
      (@base_controller || '::ApplicationController').constantize
    end

    def token_expires_in
      (@token_expires_in || 3.days).to_i
    end
  end
end
