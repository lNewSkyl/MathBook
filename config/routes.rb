Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root "articles#index", as: "home"
  get "/about", to: "application#about"
  get "search", to: "articles#search"
  resources :users, only: [:index] do 
    member do
      patch :ban
    end
  end
  resources :articles do
    resources :comments
    resources :solutions
    member do
      delete :purge_avatar    
      patch "upvote", to: "articles#upvote"
      patch "downvote", to: "articles#downvote"

    end
  end



  resources :users, only: [:show]

  delete "attachments/:id/purge", to: "attachments#purge", as: "purge_attachment"
end