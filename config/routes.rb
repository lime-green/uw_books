Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get 'books'                       => 'books#index',   as: "books"
      get 'books/:department/:number'   => 'books#show',    as: "books_search"
      get 'courses'                     => 'courses#index', as: "courses"
      get 'courses/:department/:number' => 'courses#show',  as: "courses_search"
    end
  end
end
