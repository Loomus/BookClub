class BooksController < ApplicationController

  def index
    if params[:sort] == "asc" || "desc"
    @books = Book.avg_rating_order(params[:sort])
    else
    @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
  end
end
