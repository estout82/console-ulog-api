require 'jwt'

class Api::AnimationsController < ApplicationController
    before_action :require_login!, only: [:update, :destroy]

    def index
        @animations = Animation.all
        render json: @animations, except: [:secret_digest]
    end

    def auth
        @animation = Animation.find_by(slug: params[:animation_id])
        result = @animation.authenticate_secret(params[:secret])

        # TODO: add secret
        payload = { slug: params[:animation_id] }
        token = JWT.encode(payload, '1234')

        if result
            render json: { token: token }, status: 200
        else
            render json: {}, status: 401
        end
    end

    def show
        @animation = Animation.find_by(slug: params[:id])
        render json: @animation, except: [:secret_digest]
    end

    def create
        @animation = Animation.new(animation_params)

        if @animation.save
            render json: {
                message: "Animation created successfully"
            }
        else
            response.status = 400
            render json: @message
        end
    end

    def update

    end

    def destroy

    end

    private

    def animation_params
        params.require(:animation).permit(:name, :slug, :secret)
    end
end
