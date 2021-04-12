Rails.application.routes.draw do
  root "home#index"
  devise_for :users, :controllers => {
    :registrations => "users/registrations"
  }
  
  authenticate :user do
    get "login/multipass", to: "shopify_multipass#confirm"
    get "login/multipass/redirect", to: "shopify_multipass#login"
  end
end
