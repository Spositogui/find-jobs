Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :candidates
  devise_for :head_hunters
  get '/my_vacancies', to: 'subscriptions#index'
  get '/my_proposals', to: 'proposals#index'
  resources :subscriptions, only: [] do
    post 'highlight_candidate', on: :member
    resources :proposals, only: %i[new create]
  end
  resources :proposals, only: [:show]
  resources :jobs, only: %i[index show new create] do
    member do
      get 'subscription'
      get 'subscribers'
      post 'cofirmed_subscription'
    end
    get 'search', on: :collection
  end
  resources :candidate_profiles, only: %i[show new create edit update] do
    resources :comments, only: %i[new create]
  end

  namespace :api do
    namespace :v1 do
      resources :jobs, only: %i[index show create update]
    end
  end
end
