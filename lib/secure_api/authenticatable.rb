module SecureApi
  module Authenticatable
    extend ActiveSupport::Concern

    included do
      has_one :secure_token, as: :resource, dependent: :destroy, class_name: 'SecureApi::Token'
      before_save :encrypt_password, if: :will_save_change_to_password?

      private

      def encrypt_password
        self.password = Encryptor.new.encrypt(password)
      end
    end
  end
end
