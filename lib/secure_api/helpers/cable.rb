module SecureApi
  module Helpers
    module Cable
      extend ActiveSupport::Concern

      included do
        private

        def authenticate_cable_request!
          token = Token.find_by(token: request.params['Authorization'])
          token.nil? || token.expired? ? false : token.resource
        end
      end
    end
  end
end
