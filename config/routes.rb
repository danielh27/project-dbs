Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users, path: '', path_names: { sign_in: 'login' },
    controllers: {
      sessions: 'users/sessions',
      confirmations: 'users/confirmations',
      registrations: 'users/registrations'
    }

  devise_for :providers, path: 'providers', path_names: { sign_in: 'login'},
    controllers: {
      sessions: 'providers/sessions',
      confirmations: 'users/confirmations',
      registrations: 'providers/registrations'
    }

  root "pages#home"

  resources :services do
    resources :chats, only: %i[show create] do
      resources :messages, only: :create
    end
  end
end
