module SecureApi
  module Authenticatable
    extend ActiveSupport::Concern

    included do
      has_one :secure_token, as: :resource, dependent: :destroy, class_name: 'SecureApi::Token'
      before_save :encrypt_password, if: :will_save_change_to_password?

      def secure_api_response_default
        as_json(except: %i[password created_at updated_at])
      end

      def secure_api_response_actual
        respond_to?(:secure_api_response) ? secure_api_response : secure_api_response_default
      end

      private

      def encrypt_password
        self.password = Encryptor.new.encrypt(password)
      end
    end
  end
end
