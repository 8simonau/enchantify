Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"

  devise_for :users
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: "pages#home"

  resources :children, only: [:index, :new, :create]
  get 'children/:id/set_child', to: 'children#set_child', as: 'set_child'

  resources :stories, only: [:index, :new, :show, :edit, :update] do
    resources :story_options, only: [:new, :create]
  end
  get "/stories/:id/audio", to: "stories#render_story"

  resources :voices, only: [:index, :new, :create, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :stories, only: [:index, :new, :show, :edit, :update, :destroy] do
    resources :story_options, only: [:new, :create]
    # get "select_options", to: "story_options#select_options"
    # post "create_option", to: "story_options#create"
  end

  resources :voices, only: [:index, :new, :create, :destroy]

  get "/stories/:id/audio", to: "stories#render_story"
  put "/stories/:id/toggle_favorite", to: "stories#toggle_favorite", as: "toggle_favorite"
end
