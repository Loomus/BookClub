class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
  end

  def destroy
    @author = Author.find(params[:id])
    @books = @author.books
    Book.destroy(@books.ids)
    @author.destroy
    redirect_to books_path
  end
end
