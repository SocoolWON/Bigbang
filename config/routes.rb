Rails.application.routes.draw do
  devise_for :users
  devise_for :teachers
  get '/online' => 'courses#index'
  resources :courses
  resources :teachers, only: [:index]
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
