
class Api::AnimationsController < ApplicationController
    def test
        animation = Animation.find_by(slug: "consoleulog")
        render json: { result: animation.authenticate_secret("11234") }
    end

    def index
        @animations = Animation.all
        render json: @animations
    end

    def show
        @animation = Animation.find(params[:id])
        render json: @animation
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
