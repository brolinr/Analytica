Rails.application.routes.draw do
  devise_for :companies
  root to: 'static_pages#home'
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
end
