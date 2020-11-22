module SecureApi
  module Helpers
    module Test
      def auth_headers(resource)
        token = SecureToken.create(resource: resource).token
        { 'Authorization' => token }
      end
    end
  end
end
