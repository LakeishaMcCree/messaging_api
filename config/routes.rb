Rails.application.routes.draw do
 namespace :api do
    namespace :v1 do
      post 'register', to: 'auth#register'
      post 'login', to: 'auth#login'
      
      resources :conversations, only: [:index, :show, :create] do
        resources :messages, only: [:index, :create]
    end
  end
end
