Rails.application.routes.draw do
  get '/chatroom/:id' => 'courses#chatroom', as: 'chatroom'
  get '/board/:id' => 'posts#index', as: 'board'  
  get '/classroom' => 'courses#classroom'
  resources :posts, except: [:index]  
  post 'registration/cancel/:id' => 'registration#cancel', as: 'registration_cancel'
  post 'registration/apply/:id' => 'registration#apply', as: 'registration_apply'
  get 'registration/index' => 'registration#index'
  devise_for :users
  devise_for :teachers
  get '/online' => 'courses#index'
  resources :courses
  resources :teachers, only: [:index]
  get '/' => 'home#index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
