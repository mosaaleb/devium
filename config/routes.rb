Rails.application.routes.draw do
  
  devise_for :users, path: 'accounts', controllers: {
    registrations: 'users/registrations'
  }
  
  authenticated :user do
    root 'newsfeeds#show'
  end

  devise_scope :user do
    root 'devise/sessions#new'
  end
  
  concern :likable do
    post 'like', to: 'likes#create'
    delete 'dislike', to: 'likes#destroy'
  end
  
  resources :posts, only: :none, shallow: true, concerns: :likable do
    resources :comments, only: [:update, :destroy, :create], concerns: :likable
  end

  resources :users, only: :none, path: :relationships do
    member do
      get 'received_requests', to: 'incoming_requests#index'
      delete 'reject_request', to: 'incoming_requests#destroy'
    end
    member do
      get 'sent_requests', to: 'outgoing_requests#index'
      post 'send_request', to: 'outgoing_requests#create'
      delete 'remove_request', to: 'outgoing_requests#destroy'
    end
    member do
      post 'accept_request', to: 'friendships#create'
      delete 'remove_friend', to: 'friendships#destroy'
    end
  end

  resources :users, only: :none, path: '', param: :username do
    resource :profile, path: '', only: [:show, :edit, :update]
    resources :posts, path: '', only: [:show, :edit, :create, :update, :destroy]
  end
end


#/:id/likes/:likable_type
#/:id/dislikes/:likable_type
#/:user_username/requests/:receiver_id
