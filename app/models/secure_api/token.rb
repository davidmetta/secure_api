require 'jwt'

module SecureApi
  class Token < ApplicationRecord
    SECRET = SecureApi.encryption_secret

    belongs_to :resource, polymorphic: true
    before_validation :set_token, on: :create

    validates :token, presence: true, uniqueness: true

    def ok?
      !expired?
    end

    def expired?
      JWT.decode token, SECRET, true, { algorithm: 'HS256' }
    rescue JWT::ExpiredSignature
      true
    else
      false
    end

    def self.decode(token)
      decoded = JWT.decode token, SECRET, true, { algorithm: 'HS256' }
      decoded[0]["data"]
    end

    private

    def set_token
      exp = Time.now.to_i + 172_800
      payload = { data: resource_id, exp: exp }
      token = JWT.encode payload, SECRET, 'HS256'

      if Token.find_by_token(token)
        set_token
      else
        self.exp_date = Time.zone.at exp
        self.token = token
      end
    end
  end
end
