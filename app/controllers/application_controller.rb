class ApplicationController < ActionController::API
    @@exp = Time.now + 24.hours.to_i
    @@hmac_secret = 'shhh this is secret!'
   
    
    def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        return render json:{error:"No Token Provided or wrong format"}, status: :unauthorized unless header
        begin
            decoded_token = JWT.decode header, @@hmac_secret, true, { algorithm: 'HS256' }
            decoded_token=decoded_token[0]
        rescue JWT::ExpiredSignature => e
            render json: { errors: e.message }, status: :unauthorized
        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
            render json: { errors: "Invalid Token" }, status: :unauthorized
        end
        @current_user = User.find(decoded_token["user_id"])
    end
end
