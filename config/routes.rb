Rails.application.routes.draw do
  get 'pointed_events/index'
  devise_for :users

  root to: 'site#index'

  resources :pointed_events, only: :index
  namespace :api do
    namespace :v1 do
      resources :pointed_events, only: [:create, :index], format: :json
    end
  end
end
