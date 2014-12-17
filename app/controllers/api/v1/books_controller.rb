class Api::V1::BooksController < ApplicationController

  def index
    respond_to do |format|
      format.json { render json: JSON.pretty_generate(
        ActiveModel::ArraySerializer.new(Book.all, each_serializer: BookSerializer).as_json) }
    end
  end

  def show
    respond_to do |format|
      @books = BookRepository.find_by_course(params[:department], params[:number])
      format.json { render json: JSON.pretty_generate(
        ActiveModel::ArraySerializer.new(@books, each_serializer: BookSerializer).as_json) }
    end
  end
end
