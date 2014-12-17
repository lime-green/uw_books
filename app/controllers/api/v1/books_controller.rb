class Api::V1::BooksController < ApplicationController

  def index
    respond_to do |format|
      format.json { render json: JSON.pretty_generate(Book.all.as_json except: [:id]) }

    end
  end

  def show
    respond_to do |format|
      @books = BookRepository.find_by_course(params[:department], params[:number])
      format.json { render json: JSON.pretty_generate(@books.as_json except: [:id]) }
    end
  end
end
