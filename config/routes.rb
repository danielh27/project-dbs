Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login'}, controllers: { confirmations: 'session/confirmations', registrations: 'session/registrations' }
  devise_for :providers, path: 'providers', path_names: { sign_in: 'login'}, controllers: { sessions: 'providers/sessions' }

  root "pages#home"

  resources :services do
    resources :chats, only: %i[show create] do
      resources :messages, only: :create
    end
  end
end
