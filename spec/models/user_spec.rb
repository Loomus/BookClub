require 'rails_helper'

describe User do
  before :each do
    @book_1 = Book.create(title: "Book 1 title", pages: 300, year: 1992, cover_image: "https://iguhb7lay20b9vtl-zippykid.netdna-ssl.com/wp-content/uploads/2018/04/1_wswf9QNmKrwTB883hHb4BQ.png")
    @book_2 = Book.create(title: "Book 2 title", pages: 350, year: 1986, cover_image: "https://images.penguinrandomhouse.com/cover/9781101931288")
    @book_3 = Book.create(title: "Book 3 title", pages: 125, year: 1942, cover_image: "https://s26162.pcdn.co/wp-content/uploads/2018/08/81Ya99Bc-jL.jpg")

    @author_1 = @book_1.authors.create(name: "Michael")
    @author_2 = @book_1.authors.create(name: "John")
    @author_3 = @book_2.authors.create(name: "Bill")
    @author_4 = @book_3.authors.create(name: "Megan")

    @user_1 = User.create!(name: "John")
    @user_2 = User.create!(name: "Bill")
    @user_3 = User.create!(name: "Larry")
    @user_4 = User.create!(name: "Stella")
    @user_5 = User.create!(name: "Sarah")
    @user_6 = User.create!(name: "Kristin")

    @review_2 = Review.create!(title: "review 2", rating: 4, description: "Book 1 review", user: @user_2, book: @book_1)
    @review_12 = Review.create!(title: "review 12", rating: 1, description: "Book 1 review", user: @user_6, book: @book_1)
    @review_1 = Review.create!(title: "review 1", rating: 2, description: "Book 1 review", user: @user_4, book: @book_1)
    @review_10 = Review.create!(title: "review 10", rating: 5, description: "Book 1 review", user: @user_1, book: @book_1)
    @review_3 = Review.create!(title: "review 3", rating: 1, description: "Book 1 review", user: @user_5, book: @book_1)
    @review_11 = Review.create!(title: "review 11", rating: 3, description: "Book 1 review", user: @user_3, book: @book_1)

    @review_4 = Review.create!(title: "review 4", rating: 3, description: "Book 1 review", user: @user_1, book: @book_2)
    @review_5 = Review.create!(title: "review 5", rating: 4, description: "Book 1 review", user: @user_2, book: @book_2)
    @review_6 = Review.create!(title: "review 6", rating: 3, description: "Book 1 review", user: @user_3, book: @book_2)

    @review_7 = Review.create!(title: "review 7", rating: 3, description: "Book 1 review", user: @user_1, book: @book_3)
    @review_8 = Review.create!(title: "review 8", rating: 3, description: "Book 1 review", user: @user_2, book: @book_3)
    @review_9 = Review.create!(title: "review 9", rating: 3, description: "Book 1 review", user: @user_3, book: @book_3)
  end
  describe "Relationships" do
    it {should have_many :reviews}
    it {should have_many(:books).through(:reviews)}
  end

  describe "Validations" do
    it {should validate_presence_of :name}
  end
  describe "Class Methods" do
    it ".most_reviews" do
    book = Book.create!(title: "whatever", pages: 200, year: 1990, cover_image: "www.google.com")
    book_2 = Book.create!(title: "whatever", pages: 200, year: 1990, cover_image: "www.google.com")
    book_3 = Book.create!(title: "whatever", pages: 200, year: 1990, cover_image: "www.google.com")

    review = Review.create!(title: "new rev 1", rating: 3, description: "adkjsfalkjsdf", user: @user_3, book: book )
    review_2 = Review.create!(title: "new rev 2", rating: 3, description: "adkjsfalkjsdf", user: @user_3, book: book_2)
    review_3 = Review.create!(title: "new rev 2", rating: 3, description: "adkjsfalkjsdf", user: @user_1, book: book)
    @books = Book.all

    expect(@books.most_reviews).to eq([@user_3, @user_1, @user_2])
    end
  end
end
