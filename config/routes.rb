Rails.application.routes.draw do
  devise_for :candidates
  devise_for :head_hunters
  resources :jobs, only: [:index, :show, :new, :create]
  resources :candidate_profiles, only: [:show, :new, :create]
  root to: 'home#index'
end
