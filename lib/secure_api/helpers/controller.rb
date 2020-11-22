module SecureApi
  module Helpers
    module Controller
      extend ActiveSupport::Concern

      included do
        def current_user
          token = request.headers['Authorization']
          @current_user ||= SecureApi.user_class.find(Token.decode(token))
        end

        private

        def authenticate_request!
          token = Token.find_by(token: request.headers['Authorization'])
          return unless token.nil? || token.expired?

          render json: {
            error: {
              message: 'Invalid Token.',
              status: :unauthorized,
              code: 401
            }
          }, status: :unauthorized
        end
      end
    end
  end
end
