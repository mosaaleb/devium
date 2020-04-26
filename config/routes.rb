# frozen_string_literal: true

Rails.application.routes.draw do
  resources :notifications, only: [:index] do
    post :mark_as_read, to: 'notifications#update', on: :collection
    post :mark_as_read, to: 'notifications#update', ok: :member
  end

  devise_for :users, path: 'accounts', controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :hashtag, only: :show

  get 'all-users', to: 'users#index'

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

  resources :posts, only: %i[create edit update destroy], shallow: true, concerns: :likable do
    resources :comments, only: %i[edit update destroy create], concerns: :likable
  end

  get 'received_requests', to: 'incoming_requests#index'
  get 'sent_requests', to: 'outgoing_requests#index'

  resources :users, only: :none, path: :relationships do
    member do
      delete 'reject_request', to: 'incoming_requests#destroy'
    end

    member do
      post 'send_request', to: 'outgoing_requests#create'
      delete 'remove_request', to: 'outgoing_requests#destroy'
    end

    member do
      post 'accept_request', to: 'friendships#create'
      delete 'remove_friend', to: 'friendships#destroy'
    end
  end

  resources :users, only: :none, path: '', param: :username do
    member do
      get 'friends', to: 'friendships#index'
    end

    resource :profile, path: '', only: %i[show edit update]
    resources :posts, path: '', only: :show
  end
end
