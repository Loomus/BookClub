class UsersController < ApplicationController
  def show
    if params[:sort] == "asc"
    @user = User.find(params[:id])
    @sort_reviews = User.find(params[:id]).sort_review_date(params[:sort])
    elsif params[:sort] == "desc"
    @user = User.find(params[:id])
    @sort_reviews = User.find(params[:id]).sort_review_date(params[:sort])
    else
    @user = User.find(params[:id])
    end
  end
end
