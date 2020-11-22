SecureApi::Engine.routes.draw do
  constraints format: :json do
    # post :signup, to: 'secure_api#signup'
    post :login, to: 'secure_api#login'
    delete :logout, to: 'secure_api#logout'
    get :check_token, to: 'secure_api#check_token'
  end
end
