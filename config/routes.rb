Rails.application.routes.draw do
  devise_for :head_hunters
  root to: 'home#index'
end
