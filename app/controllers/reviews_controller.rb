class ReviewsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @review = @book.reviews.new
  end

  def create
    user_name = user_params[:user].titleize
    book = Book.find(params[:book_id])
    user = User.find_or_create_by(name: user_name)
    if user.name == "" || nil
      user.delete
      redirect_to new_book_review_path(book)
    elsif user.books.include?(book)
      redirect_to new_book_review_path(book)
    else
      review = book.reviews.new(review_params)
      user.reviews << review
      if review.save
        redirect_to book_path(book)
      else
        redirect_to new_book_review_path(book)
      end
    end
  end

  def destroy
    review = Review.find(params[:book_id])
    user = User.find(params[:id])
    review.delete
    redirect_to user_path(user)
  end

  private

  def review_params
    params.require(:review).permit(:title, :rating, :description, :user_id)
  end

  def user_params
    params.require(:review).permit(:user)
  end
end
