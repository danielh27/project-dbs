Rails.application.routes.draw do
  get 'stimulus/hhh'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, path: '', path_names: { sign_in: 'login' }, controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    registrations: 'users/registrations'
  }

  devise_for :providers, path: 'providers', path_names: { sign_in: 'login'}, controllers: {
    sessions: 'providers/sessions',
    confirmations: 'providers/confirmations',
    registrations: 'providers/registrations'
  }

  devise_scope :user do
    authenticated :user do
      get 'dashboard', to: "users/dashboard#index", as: :users_authenticated_root
    end
  end

  devise_scope :provider do
    authenticated :provider do
      namespace :providers do
        get 'dashboard', to: "dashboard#index", as: :authenticated_root
      end
    end
  end

  resources :services, shallow: true do
    resources :chats, param: :token do
      resources :messages, only: :create
      get :my_chats, controller: :chats, on: :member
    end
  end

  root "pages#home"
end
