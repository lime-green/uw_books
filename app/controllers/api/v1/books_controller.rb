class Api::V1::BooksController < ApplicationController
  respond_to :json

  def index
    books = Book.page(params[:page]).per_page(40)
    respond_with(JSON.pretty_generate(
      ::BookArraySerializer.new(books, each_serializer: BookSerializer).as_json))
  end

  def show
    @books = BookRepository.find_by_course(params[:department], params[:number])
    respond_with(JSON.pretty_generate(
      ActiveModel::ArraySerializer.new(@books, each_serializer: BookSerializer).as_json))
  end
end
