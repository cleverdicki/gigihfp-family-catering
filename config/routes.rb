Rails.application.routes.draw do
  resources :order_menus
  resources :menu_categories
  resources :orders
  resources :menus
  resources :categories
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
