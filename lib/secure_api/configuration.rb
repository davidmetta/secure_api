module SecureApi
  class Configuration
    attr_accessor :user_class,
                  :base_controller,
                  :token_expires_in,
                  :encryption_secret
  end
end
