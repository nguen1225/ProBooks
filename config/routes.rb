Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :books
  get 'tags/:tag', to: 'books#index', as: :tag
end
