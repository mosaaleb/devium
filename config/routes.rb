Rails.application.routes.draw do
  get ':username/:post_id', to: 'posts#show', as: :post
  get ':username/:post_id/edit', to: 'posts#edit'
  put ':username/:post_id', to: 'posts#update'
  delete ':username/:post_id', to: 'posts#destroy'

  get ':username', to: 'profiles#show', as: :profile
  get ':username/edit', to: 'profiles#edit'
  put ':username', to: 'profiles#update'


  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'newsfeed#show'
end




  ### TODO
  # resources :profiles, only: [:show, :edit, :update] do
  #   get ':username', to: 'profiles#show'
  # end