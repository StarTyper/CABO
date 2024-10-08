Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "pages#home"
  get "home", to: "pages#home", as: :home

  resources :games, only: %i[index show new create destroy] do
    resources :players, shallow: true
  end

  get "games/:id/play", to: "games#play", as: :play
  patch "games/:id/start", to: "games#start", as: :start
  patch "games/:id/end", to: "games#end", as: :end

  resources :users, only: %i[show new create edit update destroy] do
    resources :friendships, only: %i[index show new create update destroy], shallow: true
  end
end
