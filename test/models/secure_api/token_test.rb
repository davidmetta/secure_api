require 'test_helper'

module SecureApi
  class TokenTest < ActiveSupport::TestCase
    setup do
      @user = User.create(custom_email_attr: 'name@example.com', password: '123456')
    end

    test 'is_ok' do
      token = Token.create(resource: @user)

      assert token.ok?
      travel 3.days
      refute token.ok?
    end

    test 'is_expired' do
      token = Token.create(resource: @user)

      refute token.expired?
      travel 3.days
      assert token.expired?
    end

    test 'decode' do
      token = Token.create(resource: @user)

      assert_equal token.resource_id, Token.decode(token.token)
    end

    test 'set_token' do
      token = Token.create(resource: @user)

      assert_not_nil token.token
      assert_not_nil token.exp_date
    end
  end
end
