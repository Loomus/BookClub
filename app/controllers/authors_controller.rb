class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
  end

  def destroy
    @author = Author.destroy(params[:id])
    redirect_to books_path
  end
end
