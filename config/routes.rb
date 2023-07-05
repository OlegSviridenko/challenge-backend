Rails.application.routes.draw do
  resources :products, only: %i[index update]

  post 'order', action: :create, controller: 'orders'
end
