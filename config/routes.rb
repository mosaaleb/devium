Rails.application.routes.draw do
  devise_for :users, path: 'accounts', controllers: {
    registrations: 'users/registrations'
  }

  root 'newsfeed#show'
  
  concern :likable do
    # member do
      post 'like', to: 'likes#create'
      delete 'dislike', to: 'likes#destroy'
    # end
  end

  resources :posts, only: :none, shallow: true, concerns: :likable do
    resources :comments, only: [:update, :destroy, :create], concerns: :likable
  end
  

  resources :users, only: :none, path: '', param: :username do
    resource :profile, path: '', only: [:show, :edit, :update]
    resources :posts, path: '', only: [:show, :edit, :create, :update, :destroy]
  end
end
