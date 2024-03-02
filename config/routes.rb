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

end
