Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  post 'login', to: 'sessions#login'
  delete 'logout', to: 'sessions#logout'
  get '/profile', to: 'users#profile'
  post 'top_up', to: 'transactions#top_up'
  post 'transfer', to: 'transactions#transfer'
end
