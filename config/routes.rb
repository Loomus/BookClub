Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index'

  # books
  get '/books/new', to: 'books#new', as: :new_book
  get '/books', to: 'books#index', as: :books_path
  get '/books/:id', to: 'books#show', as: :book_path
  post '/books', to: 'books#create'
  delete '/books/:id', to: 'books#destroy', as: :book

  # reviews
  post '/books/:book_id/reviews', to: 'reviews#create', as: :book_reviews
  get '/books/:book_id/reviews', to: 'reviews#new', as: :new_book_review
  delete '/books/:book_id/reviews/:id', to: 'reviews#destroy', as: :book_review


  # users
  get '/users/:id', to: 'users#show', as: :user

  # authors
  get '/authors/:id', to: 'authors#show', as: :author
  delete '/authors/:id', to: 'authors#destroy'

  get '/admin/categories', to: 'admin/categories#index', as: :admin_categories
end
