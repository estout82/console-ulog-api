Rails.application.routes.draw do
  namespace :api do
    resources :animations
  end
end
