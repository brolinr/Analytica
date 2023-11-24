Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'

  devise_for :companies, controllers: {
    sessions: 'companies/sessions',
    registrations: 'companies/registrations',
    passwords: 'companies/passwords',
    confirmations: 'companies/confirmations'
  }

  namespace :reverse_auction do
    root to: 'dashboard#index'
    resources :auctions, except: :index do
      post '/register/', on: :member, to: 'auctions#register', as: :register
      resources :lots, only: %i[create update show destroy]
    end

    resources :lots, only: [] do
      post '/wish/', on: :member, to: 'lots#wish', as: :wish
      resources :bids, only: %i[new create destroy], shallow: true
    end

    get 'wishlist', to: 'lots#wishlist', as: :wishlist
    get '/lots-bid', to: 'bids#lots_bid', as: :lots_bid
    get '/registered', to: 'auctions#registered', as: :registered
    get '/live-auctions', to: 'auctions#live', as: :live
    get '/my-auctions', to: 'auctions#buyer_auctions', as: :my_auctions
  end
end
