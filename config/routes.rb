Rails.application.routes.draw do
  resources :warriorknowledges
  resources :tasks
  resources :articles
  resources :grades
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout'  => 'sessions#destroy'
  get 'welcome', to: 'sessions#welcome'
  get 'authorized', to: 'sessions#page_requires_login'
  get 'unapproved', to: 'cadets#unapproved'
  get 'flights/:flight', to: 'cadets#flights'
  get 'calendar', to: 'events#calendar'
  get '/alltasks', to: 'tasks#alltasks'
  get 'completedtasks', to: 'tasks#completed'
  get 'uncompletedtasks', to: 'tasks#uncompleted'
  get 'latetasks', to: 'tasks#late'
  
  resources :cadets do
    resources :attendances
    resources :otscs
    resources :workouts
    resources :grades
  end
  resources :events do
    resources :attendances
    post "attendances/:id/edit"    => "attendances#edit"
  end
  resources :attendances do
    post "attendances/:id/edit"    => "attendances#edit"
  end
  resources :password_resets
  root 'sessions#welcome'
  
  get "/about" => "pages#about"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
