class ReviewsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new
  end

  def create
      user_name = user_params[:user].titleize
      user = User.find_by(name: user_name)
      @book = Book.find(params[:book_id])
    if user == nil
      @book.reviews << @review = Review.create(review_params)
      @user = User.create(name: user_name)
      @user.reviews << @review
      redirect_to book_path(@book)
    elsif user != nil && user.books.include?(@book)
      redirect_to new_book_review_path(@book)
    elsif user != nil && user.books.include?(@book) == false
      @book.reviews << @review = Review.create(review_params)
      @user = User.create(name: user_name)
      @user.reviews << @review
      redirect_to book_path(@book)
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :rating, :description)
  end

  def user_params
    params.require(:review).permit(:user)
  end
end
