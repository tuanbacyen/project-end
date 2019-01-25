Rails.application.routes.draw do
  get "errors/file_not_found"
  get "errors/internal_server_error"
  get "home/index"
  root "home#index"
  resources :schools
  resources :semesters
  resources :units
  get "new_auto_unit", to: "units#new_auto", as: "new_auto_unit"
  post "create_auto_unit", to: "units#create_auto", as: "create_auto_unit"
  resources :subjects
  get "new_auto_subject", to: "subjects#new_auto", as: "new_auto_subject"
  post "create_auto_subject", to: "subjects#create_auto", as: "create_auto_subject"
  resources :notify_types
  resources :point_types
  resources :classrooms do
    resources :class_subjects, only: [:index, :new, :create, :destroy]
  end
  resources :students do
    resources :student_classrooms, only: [:index, :new, :create, :destroy]
  end
  get "students_classs", to: "students#students_classs", as: "students_classs"
  post "student_in_school", to: "students#student_in_school", as: "student_in_school"
  resources :student_subjects
  resources :new_semesters, only: :create
  post "teacher_can_teach", to: "new_semesters#teacher_can_teach", as: "teacher_can_teach"
  resources :points
  resources :user_subjects, only: [:index, :new, :create, :destroy]
  resources :feedbacks, expect: :edit
  namespace :admin do
    resources :users do
      resources :school_user, only: [:index, :new, :create, :destroy]
    end
    get "users_confirmed", to: "users#index_confirm", as: "users_confirmed"
    get "new_confirm", to: "users#new_confirm", as: "new_confirm"
    post "confirm", to: "users#confirm", as: "confirm"
  end
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions",
    passwords: "users/passwords"}
end
