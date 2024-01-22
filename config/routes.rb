Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
  get 'email', to: 'static_pages#email'



  resources :companies, only: %i[new create]

  devise_for :companies, skip: [:sessions, :passwords, :confirmations]

  # Move the devise_scope block here
  devise_scope :company do
    get '/sign_in', to: 'devise/sessions#new', as: :new_company_session
    post '/sign_in', to: 'devise/sessions#create', as: :company_session
    delete 'company/sign_out', to: 'devise/sessions#destroy', as: :destroy_company_session
    get 'company/password', to: 'devise/passwords#new', as: :new_company_password
    get 'company/password/edit', to: 'devise/passwords#edit', as: :edit_company_password
    put 'company/password', to: 'devise/passwords#update', as: :company_password
    post 'company/password', to: 'devise/passwords#create', as: :company_passwords
    get 'company/confirmation', to: 'devise/confirmations#show', as: :company_confirmation
    get 'company/confirmation/new', to: 'devise/confirmations#new', as: :new_company_confirmation
    post 'company/confirmation', to: 'devise/confirmations#create', as: :company_confirmations
  end

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

  devise_for :administrators, only: %i[sessions unlocks]
  namespace :admin do
    resources :auctions
    resources :auction_registrations
    resources :bids
    resources :categories
    resources :companies
    resources :lots
    resources :watched_lots

    root to: "auctions#index"
  end
  
  resources :company_onboardings do
    post '/approve/', on: :member, to: 'company_onboardings#approve', as: :approve
  end
end
