Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users, controllers: {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :users, only: %i(index show edit update)
  resources :books do
    resources :reviews, only: %i(edit update create destroy) do
        resources :claps, only: %i(create destroy)
    end
  end
  # get 'tag/:tag_name', to: 'books#index'
  get 'tags/:tag', to: 'books#index', as: :tag
  get 'search', to: 'books#search'
end
