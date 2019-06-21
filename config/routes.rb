Rails.application.routes.draw do
  get 'newsfeeds/show'
  devise_for :users, path: 'accounts', controllers: {
    registrations: 'users/registrations'
  }
  
  

  root 'newsfeed#show'
  
  resources :posts, only: :none do
    member do
      post 'add_comment', to: 'comments#create'
      delete 'remove_comment/:comment_id', to: 'comments#destroy', as: :delete_comment
    end
  end
  
  resources :users, only: :none, path: '', param: :username do
    resource :profile, path: '', only: [:show, :edit, :update]
    resources :posts, path: '', only: [:show, :edit, :create, :update, :destroy] do
    end
  end
end
