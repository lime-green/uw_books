class Api::V1::BooksController < ApplicationController
  respond_to :json

  def index
    books = BookRepository.where_course(book_params_index)
    books = books.page(params[:page]).per_page(40)
    respond_with(JSON.pretty_generate(
      ::ArraySerializer.new(books, each_serializer: BookSerializer).as_json))
  end

  def show
    books = BookRepository.where_course(book_params_show)
    books = books.page(params[:page]).per_page(40)

    respond_with(JSON.pretty_generate(
      ::ArraySerializer.new(books, each_serializer: BookSerializer).as_json))
  end

  private
  def book_params_index
    params.permit(:term)
  end
  def book_params_show
    params.permit(:department, :number, :section, :term)
  end
end
