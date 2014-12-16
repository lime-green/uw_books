class Api::V1::BooksController < ApplicationController

  def index
    respond_to do |format|
      format.json { render json: Book.all, except: [:id] }
    end
  end
end
