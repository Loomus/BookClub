class ReviewsController < ApplicationController
  def new
    # binding.pry
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new
  end

  def create
    @book = Book.find(params[:book_id])
    user_name = user_params[:user].titleize
    if User.find_by(name: user_name) == nil && @book
    @review = Review.create(review_params)
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
