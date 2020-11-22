require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  test 'reject unauthorized requests' do
    user = User.create(custom_email_attr: 'name@example.com', password: '123456')
    token = SecureApi::Token.create(resource: user)

    get root_url
    assert_response 401
    assert_equal 'Invalid Token.', @response.parsed_body['error']['message']

    get root_url, headers: { 'Authorization': token.token }
    assert_response :success
  end
end
