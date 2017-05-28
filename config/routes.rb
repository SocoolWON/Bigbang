Rails.application.routes.draw do
  get '/registration/search' => 'registration#search', as: 'search'
  get '/registration/private' => 'registration#privateTutoring'
  get '/registration/public' => 'registration#publicTutoring'
  get '/chatroom/:id' => 'courses#chatroom', as: 'chatroom'
  get 'classroom/:id/board' => 'posts#index', as: 'board'  
  get '/classroom' => 'courses#classroom'
  resources :posts, except: [:index]
  post 'registration/cancel/:id' => 'registration#cancel', as: 'registration_cancel'
  post 'registration/apply/:id' => 'registration#apply', as: 'registration_apply'
  resources :courses
  devise_for :users, controllers: {
        sessions: 'users/sessions', 
        registrations: 'users/registrations',
        confirmations: 'confirmations'
      }
  devise_for :teachers
  get '/online' => 'courses#index'
  resources :teachers, only: [:index]
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
