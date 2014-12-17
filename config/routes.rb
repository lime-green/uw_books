Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get 'books' => 'books#index'
      get 'courses/:department/:number' => 'books#show'
    end
  end
end
