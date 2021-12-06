class ApplicationController < ActionController::API
    before_action :decode_token

    rescue_from JWT::DecodeError do
        render json: {
            message: "Invalid JWT",
            error: "unable to decode the jwt included in the 'Authorization' header"
        }, status: 400
    end

    def decode_token
        auth_header = request.headers["Authorization"]

        auth_header_split = auth_header.split(' ')
        
        if auth_header_split.count > 1
            token = auth_header_split[1]
            
            decoded_token = JWT.decode token, nil, false
            
            if decoded_token
                # TODO: add some checks for empty array, missing key, etc..
                @current_animation = decoded_token[0]["animation"]
            end
        end
    end

    def require_login!
        unless @current_animation
            render json: {  }, status: :unauthorized
        end
    end
end
