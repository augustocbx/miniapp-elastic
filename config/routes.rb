Rails.application.routes.draw do
  resources :documents


  root to: 'documents#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
