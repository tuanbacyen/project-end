Rails.application.routes.draw do
  get "errors/file_not_found"
  get "errors/internal_server_error"
  get "home/index"
  root "home#index"
  resources :schools
  resources :semesters
  resources :units
  resources :subjects
  get "new_auto_subject", to: "subjects#new_auto", as: "new_auto_subject"
  post "create_auto_subject", to: "subjects#create_auto", as: "create_auto_subject"
  resources :notify_types
  namespace :admin do
    resources :users
    get "users_confirmed", to: "users#index_confirm", as: "users_confirmed"
    put "confirm", to: "users#confirm", as: "confirm"
  end
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions",
    passwords: "users/passwords"}
end
