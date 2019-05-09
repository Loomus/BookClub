class BooksController < ApplicationController

  def index
    if params[:sort] == "rating"
      @books = Book.avg_rating_order(params[:order])
    elsif params[:sort] == "pages"
      @books = Book.sort_page_count(params[:order])
    elsif params[:sort] == "reviews"
      @books = Book.sort_reviews(params[:order])
    else
      @books = Book.all
    end
    @highest_rated = Book.highest_rated
    @lowest_rated = Book.lowest_rated
  end

  def show
    @book = Book.find(params[:id])
  end
end
