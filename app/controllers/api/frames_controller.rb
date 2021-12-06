
class Api::FramesController < ApplicationController

    def index
        animation = Animation.includes(:frames).find(params[:animation_id])

        # TODO: order by 'order' attr
        render json: { data: animation.frames }, status: 200
    end

    # get a single frame
    def show
        animation_id = params[:animation_id]
        position = params[:id] # TODO: fix the parameter naming
        frame = AnimationFrame.where(animation_id: animation_id, position: position).first

        render json: { data: frame }, status: 200
    end

    # create a new frame
    def create
        new_frame = AnimationFrame.new(animation_params)
        new_frame.animation_id = params[:animation_id]
        new_frame.position = get_next_position

        if new_frame.save
            render json: {
                data: new_frame
            },
            status: 200
        else
            render json: {
                message: "Unable to save frame"
            }, status: 500
        end
    end

    # update a frame
    def update
        animation = Animation.includes(:frames).find(params[:animation_id])
        frame = animation.frames.where(position: params[:id])
        
        if frame.update(animation_params)
            render json: {
                message: "Updated frame successfully"
            }, status: 200
        end
    end

    # destroy a frame
    def destroy
        animation = Animation.includes(:frames).find(params[:animation_id])
        frame = animation.frames.where(position: params[:id]).first
        
        if frame.destroy
            render json: {
                message: "Deleted frame successfully"
            }, status: 200
        end
    end

    private

    def get_next_position
        frame = Animation.includes(:frames).find(params[:animation_id]).frames.order(position: :desc).first
        return frame.position + 1
    end
    
    def animation_params
        params.require(:animation).permit(:data)
    end
end