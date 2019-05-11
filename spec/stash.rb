def create
  @book = Book.new(book_params)
  if @book.save
    authors = author_params[:authors].titleize.split(", ")
    authors.each do |author|
      new_author = Author.find_or_create_by(name: author)
      new_author.books << @book
    end
    redirect_to book_path(@book)
  else
  @book = Book.new
  render :new
  end
end

private

def book_params
  params.require(:book).permit(:title, :pages, :year, :cover_image)
end

def author_params
  params.require(:book).permit(:authors)
end

def split_authors

end

if User.find_by(name: user_name)
@review = Review.create(review_params)
@user = User.create(name: user_name)
@user.reviews << @review
