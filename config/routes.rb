Rails.application.routes.draw do
  devise_for :users, path: 'accounts', controllers: {
    registrations: 'users/registrations'
  }
  
  root 'newsfeed#show'
  
  resources :users, only: :none, path: '', param: :username do
    resource :profile, path: '', only: [:show, :edit, :update]
    resources :posts, path: '', only: [:show, :edit, :create, :update, :destroy]
  end
end
