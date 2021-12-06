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

        unless auth_header == nil
            auth_header_split = auth_header.split(' ')
            
            if auth_header_split.count > 1
                token = auth_header_split[1]
                
                decoded_token = JWT.decode(token, '1234', true, algorithm: 'HS256')
                
                if decoded_token
                    # TODO: add some checks for empty array, missing key, etc..
                    @current_slug = decoded_token[0]["slug"]
                end
            end
        end
    end

    def require_login!
        unless @current_slug
            render json: {  }, status: :unauthorized
        end
    end
end
