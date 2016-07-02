Rails.application.routes.draw do
  get "", to: "tasks#index", as: "top"
  root "tasks#index"

  resource :user_session
  resource :user, only: [:new, :create, :destroy]

  namespace :api, defaults: { format: :json } do
    scope module: :login do
      post "login", action: :login
      get "logout", action: :logout
      post "create_user", action: :create_user
    end

    resources :tasks, only: [:index, :create, :update, :destroy], param: :sync_token do
      member do
        post "done"
      end
      collection do
        get "completed"
        post "sync"
      end
    end
  end

  resources :tasks, only: [:index, :new, :create, :update, :destroy] do
    member do
      post "done"
      post "undo"
    end
    collection do
      get "completed"
      get "today"
      get "weekly"
    end
  end

  resource :setting, only: [:show, :update]

  # namespace :user do
  #   resource :name, only: [:update]
  #   resource :email, only: [:update]
  #   resource :password, only: [:update]
  #   resource :reset_password
  # end

end
