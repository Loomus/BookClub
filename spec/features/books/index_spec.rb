require 'rails_helper'

RSpec.describe "Book index page" do
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

  describe "When I visit /books"
    it "Displays title, page number, year published, cover_image, and author/authors who wrote the book" do

      visit books_path

      within("#book-info-#{@book_1.id}") do
      expect(page).to have_content(@book_1.title)
      expect(page).to have_content(@book_1.pages)
      expect(page).to have_content(@book_1.year)
      expect(page).to have_xpath('//img[@src="https://iguhb7lay20b9vtl-zippykid.netdna-ssl.com/wp-content/uploads/2018/04/1_wswf9QNmKrwTB883hHb4BQ.png"]')
      expect(page).to have_content(@author_1.name)
      expect(page).to have_content(@author_2.name)
      end
      within("#book-info-#{@book_2.id}") do
      expect(page).to have_content(@book_2.title)
      expect(page).to have_content(@book_2.pages)
      expect(page).to have_content(@book_2.year)
      expect(page).to have_xpath('//img[@src="https://images.penguinrandomhouse.com/cover/9781101931288"]')
      expect(page).to have_content(@author_3.name)
      end
      within("#book-info-#{@book_3.id}") do
      expect(page).to have_content(@book_3.title)
      expect(page).to have_content(@book_3.pages)
      expect(page).to have_content(@book_3.year)
      expect(page).to have_xpath('//img[@src="https://s26162.pcdn.co/wp-content/uploads/2018/08/81Ya99Bc-jL.jpg"]')
      expect(page).to have_content(@author_4.name)
      end
    end
    it "Next to each book title, I see its average book rating, and total number of reviews" do

      visit books_path

      within("#book-rev-stat-#{@book_1.id}") do
        expect(page).to have_content("Average Rating: 4.0")
        expect(page).to have_content("Total Reviews: 3")
      end
      within("#book-rev-stat-#{@book_2.id}") do
        expect(page).to have_content("Average Rating: 3.3")
        expect(page).to have_content("Total Reviews: 3")
      end
      within("#book-rev-stat-#{@book_3.id}") do
        expect(page).to have_content("Average Rating: 3.0")
        expect(page).to have_content("Total Reviews: 3")
      end
    end
    it "All instances of a books title is a link to a show page" do

      visit books_path

      within("#book-info-#{@book_1.id}") do
        expect(page).to have_link(@book_1.title)
      end
      within("#book-info-#{@book_2.id}") do
        expect(page).to have_link(@book_2.title)
      end
      within("#book-info-#{@book_3.id}") do
        click_link @book_3.title
      end
      expect(current_path).to eq(book_path(@book_3))
  end
end
