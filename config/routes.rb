Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :order_menus
      resources :menu_categories
      resources :orders
      resources :menus
      resources :categories
    end
  end
end
