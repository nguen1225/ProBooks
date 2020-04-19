Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root 'homes#top'

  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  namespace :admins do
    root "dashboards#index"
    resources :users, only: %i(index destroy)
    resources :books, only: %i(index destroy) do
    end
  end
  devise_for :users, controllers: {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :contacts, only: %i(create)
  resources :categories, only: %i(index create destroy)
  resources :users, only: %i(index show edit update)
  resources :notifications, only: %i(index)
  resources :books do
    resources :favorites, only: %i(create destroy)
    resources :reviews, only: %i(edit update create destroy) do
        resources :claps, only: %i(create destroy)
    end
  end
  get 'tags/:tag', to: 'books#index', as: :tag
  get 'tag/tag_name', to: 'books#index'
  get 'reviews', to: 'reviews#index'
  post "csv_books_import", to: "admins/books#import"
end
