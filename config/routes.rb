Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login'}, controllers: { confirmations: 'session/confirmations', registrations: 'session/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "pages#home"

  resources :services
  get '/hola', to: 'pages#hola'
end
