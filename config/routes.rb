Rails.application.routes.draw do
  get 'users/:user_id/gift_cards/sent', to: 'gift_cards#sent', as: 'user_sent_gift_cards'

  # get 'gift_cards/:id', to: 'gift_cards#public_show', as: 'gift_card'

  resources :users, only: [:new, :create, :edit, :update, :show] do
    resources :gift_cards, only: [:index, :new, :create, :show]
  end
  
  # omniauth callback
  get '/auth/facebook/callback' => 'sessions#create'

  get '/invite', to: 'users#new_from_gift_card'
  patch '/invite', to: 'users#create_from_gift_card'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  delete 'sessions', to: 'sessions#destroy'
  root to: 'sessions#welcome'
end
