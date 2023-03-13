Rails.application.routes.draw do
  get 'chatrooms/show'
  devise_for :users, path: '', path_names: { sign_in: 'login'}, controllers: { confirmations: 'session/confirmations', registrations: 'session/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "pages#home"

  resources :services
  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end
end
