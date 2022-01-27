Rails.application.routes.draw do
  resources :invoices
  resources :customers
  resources :businesses
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post "/invoice-quote", to: "invoices#quote"
end
