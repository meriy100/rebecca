Rails.application.routes.draw do
  # get "", to: "tasks#index", as: "top"
  root "user_sessions#new", as: "top"

  resource :user_session, only: [:new, :create, :destroy]
  resource :user, only: [:new, :create, :update, :destroy]

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
      post "import"
    end
  end

  resources :events, only: [:update] do
    collection do
      post :import
    end
    resources :tasks, only: [:index], module: :events
  end

  resources :google_accounts, only: [:update, :destroy] do
    collection do
      get "google_callback"
    end
  end

  resources :google_calendars, only: [:update, :destroy]

  resource :setting, only: [:show, :update] do
    get "oath"
    get "google_callback"
  end

  resources :categories, only: [:create, :update, :destroy] do
    resources :tasks, module: :categories, only: [:index]
  end
end
