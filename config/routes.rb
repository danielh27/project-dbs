Rails.application.routes.draw do
  devise_for :users

  root "pages#home"

  resources :services
  get '/hola', to: 'pages#hola'
end
