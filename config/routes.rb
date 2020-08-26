Rails.application.routes.draw do
  resources :bookmarks
  resources :images, only: %w[show]
  root to: 'top#index'
end
