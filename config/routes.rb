Rails.application.routes.draw do
  devise_for :candidates
  devise_for :head_hunters
  root to: 'home#index'
end
