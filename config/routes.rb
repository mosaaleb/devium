Rails.application.routes.draw do

  resources :users, only: :none, path: '', param: :username do
    resource :profile, path: '', only: [:show, :edit, :update]
    resources :posts, path: '', only: [:show, :edit, :update, :destroy]
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'newsfeed#show'
end
