Rails.application.routes.draw do
  devise_for :users
  resources :events
  resources :users
  resources :enrollments

  resources :events do
    resources :users
  end

  root to: 'events#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
