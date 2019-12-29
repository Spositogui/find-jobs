Rails.application.routes.draw do
  devise_for :candidates
  devise_for :head_hunters
  resources :jobs, only: [:index, :show, :new, :create] do
    get 'search', on: :collection
    get 'subscription', on: :member
    get 'subscribers', on: :member
    post 'cofirmed_subscription', on: :member
    resources :proposals, only: [:new, :create]
  end
  resources :candidate_profiles, only: [:show, :new, :create, :edit, :update] do
    resources :comments, only: [:new, :create]
  end
  get '/my_vacancies', to: 'subscriptions#index'
  root to: 'home#index'
end
