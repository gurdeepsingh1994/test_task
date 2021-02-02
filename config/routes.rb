Rails.application.routes.draw do
  resources :stories, only: [:create, :show]
end
