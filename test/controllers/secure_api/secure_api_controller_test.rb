require 'test_helper'

module SecureApi
  class SecureApiControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
      @user = User.create(custom_email_attr: 'name@example.com', password: '123456')
      @error_messages = SecureApi::API_ERRORS
    end

    test 'login' do
      assert_no_difference 'Token.count' do
        post login_url, params: { email: @user.email, password: '123' }
        assert_response 401
        assert_equal @error_messages[:wrong_credentials], @response.parsed_body['error']['message']
      end

      assert_difference 'Token.count', +1 do
        post login_url, params: { email: @user.email, password: '123456' }
        assert_response :success
      end

      post login_url, params: { email: @user.email }
      assert_response 401
      assert_equal @error_messages[:missing_field], @response.parsed_body['error']['message']
    end

    test 'logout' do
      assert_no_difference 'Token.count' do
        delete logout_url
        assert_response 401
        assert_equal @error_messages[:failed_logout], @response.parsed_body['error']['message']
      end

      token = Token.create(resource: @user)
      assert_difference 'Token.count', -1 do
        delete logout_url, headers: { 'Authorization': token.token }
        assert_response :success
      end
    end

    test 'check_token' do
      token = Token.create(resource: @user)
      get check_token_url, params: { access_token: token.token }
      assert_response :success

      travel 3.days
      get check_token_url, params: { access_token: token.token }
      assert_response 401
      assert_equal @error_messages[:invalid_token], @response.parsed_body['error']['message']
    end
  end
end
