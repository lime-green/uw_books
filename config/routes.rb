Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get 'books'                       => 'books#index'
      get 'books/:department/:number'   => 'books#show'
      get 'courses'                     => 'courses#index'
      get 'courses/:department/:number' => 'courses#show'
    end
  end
end
