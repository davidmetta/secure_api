class ApplicationController < ActionController::API
  before_action :authenticate_request!

  def root
  end
end
