Rails.application.routes.draw do
  get ':username', to: 'profiles#show', as: :profile
  get ':username/edit', to: 'profiles#edit'
  put ':username/update/', to: 'profiles#update'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root 'newsfeed#show'
end




  ### TODO
  # resources :profiles, only: [:show, :edit, :update] do
  #   get ':username', to: 'profiles#show'
  # end