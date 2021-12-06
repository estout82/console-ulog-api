Rails.application.routes.draw do
  get "/api/animations/test", to: "api/animations#test"

  namespace :api do
    resources :animations do
      resources :frames

      post "/auth", to: "animations#auth"
    end
  end
end
