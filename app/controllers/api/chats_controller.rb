class Api::ChatsController < ApplicationController
    def index
        slug = params[:animation_id]
        animation = Animation.includes(:chats).find_by(slug: slug)

        render json: animation.chats, status: 200
    end

    def create
        slug = params[:animation_id]
        animation = Animation.find_by(slug: slug)
        chat = Chat.new(chat_params)
        chat.animation = animation

        if chat.save
            ActionCable.server.broadcast 'chats', chat.body

            render json: { message: "Created chat successfuly" }, status: 200
        else
            render json: { message: "Unable to create chat" }, status: 400
        end
    end

    private

    def chat_params
        params.require(:chat).permit(:body)
    end
end
