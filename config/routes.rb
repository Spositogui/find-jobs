Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :candidates
  devise_for :head_hunters
  get '/my_vacancies', to: 'subscriptions#index'
  resources :subscriptions, only: [] do
    post 'highlight_candidate', on: :member
    resources :proposals, only: [:new, :create, :show]
  end
  
  resources :jobs, only: [:index, :show, :new, :create] do
    member do
      get 'subscription'
      get 'subscribers'
      post 'cofirmed_subscription'
    end
    get 'search', on: :collection
  end

  resources :candidate_profiles, only: [:show, :new, :create, :edit, :update] do
    resources :comments, only: [:new, :create]
  end
end
