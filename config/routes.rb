Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  
  root to: "home#index"
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"


  delete "logout", to: "sessions#destroy"  
end
