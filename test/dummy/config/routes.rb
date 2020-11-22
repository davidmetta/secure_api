Rails.application.routes.draw do
  mount SecureApi::Engine => "/user"

  root to: 'application#root'
end
