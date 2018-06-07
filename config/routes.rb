Rails.application.routes.draw do
  
  mount ActionCable.server => '/cable'
  resources :posts
  get 'messages/index'
  get 'conversations/index'
	mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :friends
  devise_for :users, :controllers => { registrations:
'registrations' }
resources :users do
   resources :chats, only: [:index, :show, :create]
  end 
  resources :users do
      resources :posts do
        resources :likes
      end
    end
  resources :messages, only:[:create]

  root 'users#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
