require 'rails_helper'


describe Book do
  before :each do
    @book_1 = Book.create(title: "Book 1 title", pages: 300, year: 1992, cover_image: "https://iguhb7lay20b9vtl-zippykid.netdna-ssl.com/wp-content/uploads/2018/04/1_wswf9QNmKrwTB883hHb4BQ.png")
    @book_2 = Book.create(title: "Book 2 title", pages: 250, year: 1986, cover_image: "https://images.penguinrandomhouse.com/cover/9781101931288")
    @book_3 = Book.create(title: "Book 3 title", pages: 125, year: 1942, cover_image: "https://s26162.pcdn.co/wp-content/uploads/2018/08/81Ya99Bc-jL.jpg")

    @author_1 = @book_1.authors.create(name: "Michael")
    @author_2 = @book_1.authors.create(name: "John")
    @author_3 = @book_2.authors.create(name: "Bill")
    @author_4 = @book_3.authors.create(name: "Megan")

    @user_1 = User.create!(name: "John")
    @user_2 = User.create!(name: "Bill")
    @user_3 = User.create!(name: "Larry")

    @review_1 = Review.create!(title: "review 1", rating: 5, description: "Book 1 review", user: @user_1, book: @book_1)
    @review_2 = Review.create!(title: "review 2", rating: 4, description: "Book 1 review", user: @user_2, book: @book_1)
    @review_3 = Review.create!(title: "review 3", rating: 3, description: "Book 1 review", user: @user_3, book: @book_1)

    @review_4 = Review.create!(title: "review 4", rating: 3, description: "Book 1 review", user: @user_1, book: @book_2)
    @review_5 = Review.create!(title: "review 5", rating: 4, description: "Book 1 review", user: @user_2, book: @book_2)
    @review_6 = Review.create!(title: "review 6", rating: 3, description: "Book 1 review", user: @user_3, book: @book_2)

    @review_7 = Review.create!(title: "review 7", rating: 3, description: "Book 1 review", user: @user_1, book: @book_3)
    @review_8 = Review.create!(title: "review 8", rating: 4, description: "Book 1 review", user: @user_2, book: @book_3)
    @review_9 = Review.create!(title: "review 9", rating: 2, description: "Book 1 review", user: @user_3, book: @book_3)
  end
  describe "Relationships" do
    it { should have_many :book_authors }
    it { should have_many(:authors).through(:book_authors)}
  end
  describe "Validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :pages }
    it { should validate_presence_of :year }
    it { should validate_presence_of :cover_image }
  end
  describe "Instance Methods" do
    it ".avg_rating" do

      expect(@book_1.avg_rating.to_i).to eq(4)
      expect(@book_2.avg_rating.to_i).to eq(3.3)
      expect(@book_3.avg_rating.to_i).to eq(3)
    end
    it ".review_count" do

      expect(@book_1.review_count).to eq(3)
      expect(@book_2.review_count).to eq(3)
      expect(@book_3.review_count).to eq(3)
    end
  end
end
