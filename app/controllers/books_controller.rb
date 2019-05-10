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
    @top_users = User.most_reviews
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    title = book_params[:title].titleize
    pages = book_params[:pages]
    year = book_params[:year]
    cover_image = book_params[:cover_image]
    if Book.find_by(title: title)
      redirect_to new_book_path
    else @book = Book.create(title: title, pages: pages, year: year, cover_image: cover_image)
      @authors = author_params[:authors]
      @authors.titleize.split(", ").each do |author_name|
      @new_authors = Author.find_or_create_by(name: author_name)
      @book.authors << @new_authors
      end
      redirect_to book_path(@book)
    end
  end

private

  def book_params
    params.require(:book).permit(:title, :pages, :year, :cover_image)
  end

  def author_params
    params.require(:book).permit(:authors)
  end

end
