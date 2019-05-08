class BooksController < ApplicationController

  def index
    if params[:rating] == "asc" || "desc"
    @books = Book.avg_rating_order(params[:rating])
    elsif params[:pages] == "asc" || "desc"
    @books = Book.all
    else
    @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
  end
end
