Rails.application.routes.draw do
  get 'login', to: 'login#index', as: 'login'
  get 'logout', to: 'login#logout'
  post 'login/login'
  get 'sign_up', to: "login#sign_up", as: "sign_up"
  post 'create_user', to: "login#create_user", as: "create_user"
  get '', to: 'tasks#index', as: 'top'
  root 'tasks#index'

  resources :tasks do
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
