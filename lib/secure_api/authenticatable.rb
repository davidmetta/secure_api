module SecureApi
  module Authenticatable
    extend ActiveSupport::Concern

    included do
      has_one :secure_token, as: :resource, dependent: :destroy, class_name: 'SecureApi::Token'
      before_save :encrypt_password, if: "will_save_change_to_#{SecureApi.password_attr}?".to_sym

      alias_attribute :secure_password, SecureApi.password_attr
      alias_attribute :secure_email, SecureApi.email_attr

      def self.find_by_secure_email(string)
        find_by(SecureApi.email_attr => string)
      end

      def secure_api_response_default
        if respond_to?(:secure_api_response)
          secure_api_response
        else
          as_json(except: %I[#{SecureApi.password_attr} created_at updated_at])
        end
      end

      private

      def encrypt_password
        send("#{SecureApi.password_attr}=", Encryptor.new.encrypt(password))
      end
    end
  end
end
