Rails.application.routes.draw do
  get 'oauth_test/index'
  root 'homes#top'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :books
  get 'tags/:tag', to: 'books#index', as: :tag
end
