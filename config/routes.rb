Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :comments
      resources :blogs
      resources :users
    end
  end
  post '/login', to: 'base#login'
  get '/*a', to: 'base#not_found'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
