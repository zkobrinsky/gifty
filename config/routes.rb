Rails.application.routes.draw do
  resources :users, only: [:new, :create] do
    resources :gift_cards, only: [:index, :new, :create]
  end
  get 'users/:user_id/gift_cards/received', to: 'gift_cards#received', as: 'user_received_giftcards_path'
  get 'users/:user_id/gift_cards/sent', to: 'gift_cards#sent', as: 'user_sent_giftcards_path'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  delete 'sessions', to: 'sessions#destroy'
  root to: 'sessions#welcome'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
