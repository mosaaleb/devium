Rails.application.routes.draw do
  # get ':username/:post_id', to: 'posts#show', as: :post
  # get ':username/:post_id/edit', to: 'posts#edit'
  # put ':username/:post_id', to: 'posts#update'
  # delete ':username/:post_id', to: 'posts#destroy'

  # get ':username', to: 'profiles#show', as: :profile
  # get ':username/edit', to: 'profiles#edit'
  # put ':username', to: 'profiles#update'

  resources :users, only: :none, path: '', param: :username do
    resource :profile, path: '', only: [:show, :edit, :update]
    resources :posts, path: '', only: [:show, :edit, :update, :destroy]
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'newsfeed#show'
end
