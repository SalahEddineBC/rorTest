class BaseController < ApplicationController
    def not_found
        render json: { error: 'not_found' }, status: :unauthorized
    end
    def login
        @user = User.where("username=?",params[:username]).first
        if @user&.authenticate(params[:password])
            exp_payload = { user_id:@user.id    , exp: @@exp.to_i }
            token = JWT.encode exp_payload, @@hmac_secret, 'HS256'
            render json: { token: token, exp: @@exp.strftime("%m-%d-%Y %H:%M"),
                         username: @user.username }, status: :ok
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
    end
    
private
    def login_params
        params.permit(:email, :password)
    end
end
