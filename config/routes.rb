Rails.application.routes.draw do
  get "login", to: "login#index", as: "login"
  get "logout", to: "login#logout"
  post "login/login"
  get "sign_up", to: "login#sign_up", as: "sign_up"
  post "create_user", to: "login#create_user", as: "create_user"
  get "", to: "tasks#index", as: "top"
  root "tasks#index"

  namespace :api, defaults: { format: :json } do
    scope module: :login do
      post "login", action: :login
      get "logout", action: :logout
      post "create_user", action: :create_user
    end

    resources :tasks, except: [:show, :new, :edit], param: :sync_token do
      member do
        post "done"
      end
      collection do
        get "doned"
        post "sync"
      end
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

  namespace :admin do
    resources :users
  end
end
