class Api::V1::BooksController < ApplicationController

  def index
    respond_to do |format|
      format.json { render json: Book.all, except: [:id] }

    end
  end

  def show
    respond_to do |format|
      @books = BookRepository.find_by_course(params[:department], params[:number])
      format.json { render json: @books, except: [:id] }
    end
  end
end
