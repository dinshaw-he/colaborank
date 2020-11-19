Rails.application.routes.draw do
  devise_for :users

  root to: 'site#index'

  namespace :api do
    namespace :v1 do
      resources :pointed_events, only: [:create, :index], format: :json
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
