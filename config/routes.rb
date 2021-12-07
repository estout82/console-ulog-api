Rails.application.routes.draw do
  namespace :api do
    resources :animations do
      resources :frames
      resources :chats, only: [:index, :create]

      get "/test", to: "animations#test"

      post "/auth", to: "animations#auth"
    end
  end

  mount ActionCable.server => '/cable'
end
