Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'

  devise_for :companies

  resources :auctions do
    get '/registered_auctions', on: :member, to: 'auctions#auctions_registered', as: :auctions_registered
    post '/extend_deadline/', on: :member, to: 'auctions#extend_deadline', as: :extend_deadline
    post '/register/', on: :member, to: 'auctions#register', as: :register_company
    resources :lots, only: %i[create update show destroy] do
      post '/collect/', on: :member, to: 'lots#collect', as: :collect
      resources :bids, only: %i[new create destroy]
    end
  end

  get 'company_profile', to: 'auctions#company_profile', as: :company_profile
  get 'lots/collections', to: 'lots#collections', as: :collections
end
