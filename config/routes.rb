Rails.application.routes.draw do
  get 'login', to: 'login#index', as: 'login'
  get 'logout', to: 'login#logout'
  post 'login/login'
  get 'sign_up', to: "login#sign_up", as: "sign_up"
  post 'create_user', to: "login#create_user", as: "create_user"
  get '', to: 'tasks#index', as: 'top'
  root 'tasks#index'


  namespace :api do
    scope module: :login do
      get 'login', action: :login
      get 'logout', action: :logout
      get 'create_user', action: :create_user
      get 'sign_up', action: :sign_up
    end
  end


  resources :tasks, only: [:index, :new, :create, :update, :destroy] do
    member do
      post "done"
    end
    collection do
      get "doned"
    end
  end

  namespace :api do
    resources :tasks do
      member do
        post "done"
      end
      collection do
        get "doned"
      end
    end
  end

  namespace :admin do
    resources :users
  end
end
