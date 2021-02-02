Rails.application.routes.draw do
  get :webhook, to: 'webhook#webhook'
  post :webhook, to: 'webhook#webhook'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
