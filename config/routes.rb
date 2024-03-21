Rails.application.routes.draw do
  resources :books
  devise_for :users
  root to: 'books#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: %i(index show)
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
