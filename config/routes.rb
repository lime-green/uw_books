Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'books' => 'books#index', defaults: { format: :json }
      get 'books/:department/:course' => 'books#show', defaults: { format: :json }
    end
  end
end
