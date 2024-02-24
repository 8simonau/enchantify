Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'children/index'
  get 'children/:id/set_child', to: 'children#set_child', as: 'set_child'
  post 'children/create'

  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :stories, only: [:index, :new, :show, :edit, :update] do
    resources :story_options, only: [:new, :create]
    # get "select_options", to: "story_options#select_options"
    # post "create_option", to: "story_options#create"
  end

  resources :voices, only: [:index, :new, :create, :destroy]


end
