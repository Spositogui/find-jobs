Rails.application.routes.draw do
  devise_for :candidates
  devise_for :head_hunters
  resources :jobs, only: [:index, :show, :new, :create] do
    get 'search', on: :collection
    get 'subscription', on: :member
    post 'cofirmed_subscription', on: :member
  end
  resources :candidate_profiles, only: [:show, :new, :create, :edit, :update]
  root to: 'home#index'
end
