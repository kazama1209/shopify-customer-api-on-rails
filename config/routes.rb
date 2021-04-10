Rails.application.routes.draw do
  root "home#index"
  devise_for :users
  
  authenticate :user do
    get "login/multipass", to: "shopify_multipass#confirm"
    get "login/multipass/redirect", to: "shopify_multipass#login"
  end
end
