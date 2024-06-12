Rails.application.routes.draw do
  root 'search#index'
  post '/search/log', to: 'search#log'
  get 'search/analytics', to: 'search#analytics'

end
