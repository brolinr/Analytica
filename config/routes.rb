Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'

  devise_for :companies

  resources :auctions do
    post ':auction_id/extend_deadline/:days', on: :member, to: 'auctions#extend_deadline', as: :extend_deadline
    post ':auction_id/register/', on: :member, to: 'auctions#register', as: :register_company
  end

  get 'company_profile', to: 'auctions#company_profile', as: :company_profile
end
