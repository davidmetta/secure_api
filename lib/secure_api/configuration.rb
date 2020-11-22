module SecureApi
  class Configuration
    OPTIONS = %i[user_class base_controller token_expires_in encryption_secret email_attr password_attr].freeze

    attr_accessor(*OPTIONS)

    def user_class
      klass = @user_class || '::User'
      klass.constantize if Object.const_defined?(klass)
    end

    def base_controller
      klass = @base_controller || '::ApplicationController'
      klass.constantize if Object.const_defined?(klass)
    end

    def token_expires_in
      (@token_expires_in || 3.days).to_i
    end

    def email_attr
      @email_attr || :email
    end

    def password_attr
      @password_attr || :password
    end
  end
end
