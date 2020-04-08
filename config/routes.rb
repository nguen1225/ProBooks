Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users, controllers: {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :books do
    resources :reviews, only: %i(create destroy)
  end
  get 'tags/:tag', to: 'books#index', as: :tag
end
