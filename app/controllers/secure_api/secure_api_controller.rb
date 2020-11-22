module SecureApi
  class SecureApiController < ApplicationController
    # def signup
    #   head :ok
    # end

    def login
      email, password = params[:email], params[:password]

      if email.blank? || password.blank?
        basic_error(:missing_field) && return
      end

      @user = SecureApi.user_class.find_by_email(email)

      if @user && Encryptor.new.compare(password, @user.password)
        if @user.secure_token.nil? || @user.secure_token.expired?
          @user.secure_token&.destroy
          Token.create(resource: @user)
        end
        respond_with(@user.reload)
      else
        basic_error(:wrong_credentials)
      end
    end

    def logout
      @token = Token.find_by(token: request.headers['Authorization'])

      if @token
        @token.destroy
        head :ok
      else
        basic_error(:failed_logout)
      end
    end

    def check_token
      @token = Token.find_by(token: params[:access_token])

      if @token&.ok?
        respond_with(@token.resource)
      else
        basic_error(:invalid_token)
      end
    end

    private

    def respond_with(user)
      render json: {
        user: user.secure_api_response_actual,
        token: {
          token: user.secure_token.token,
          expiration: user.secure_token.exp_date.to_time.iso8601
        }
      }, status: :ok
    end

    def basic_error(error)
      render json: {
        error: {
          message: SecureApi::API_ERRORS[error],
          status: :unauthorized,
          code: 401
        }
      }, status: :unauthorized
    end
  end
end
