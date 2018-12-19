Rails.application.routes.draw do
  get 'errors/file_not_found'
  get 'errors/internal_server_error'
  get "home/index"
  root "home#index"
  resources :schools
  resources :semesters
  resources :units
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions",
    passwords: "users/passwords"}
end
