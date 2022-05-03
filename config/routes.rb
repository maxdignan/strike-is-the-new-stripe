Rails.application.routes.draw do
  resources :invoices
  resources :customers
  resources :businesses
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post "/invoice-quote", to: "invoices#quote"
  get  "/get_some_unpaid_invoices", to: "invoices#get_some_unpaid_invoices"
  get  "/get_last_invoice", to: "invoices#get_last_invoice"

  post "/webhook-update-invoice", to: "invoices#webhook_update_invoice"
end
