require 'rails_helper'

describe "Books Show page" do
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

    @review_1 = Review.create!(title: "review 1", rating: 2, description: "Book 1 review", user: @user_1, book: @book_1)
    @review_2 = Review.create!(title: "review 2", rating: 2, description: "Book 1 review", user: @user_2, book: @book_1)
    @review_3 = Review.create!(title: "review 3", rating: 2, description: "Book 1 review", user: @user_3, book: @book_1)

  end
  describe "When I visit show page" do
    it "I see title, author/s page number, year published, cover image" do

      visit book_path(@book_1)

      expect(page).to have_content("#{@book_1.title} Show Page")
      expect(page).to have_content(@author_1.name)
      expect(page).to have_content(@author_2.name)
      expect(page).to have_content("Page Number: #{@book_1.pages}")
      expect(page).to have_xpath('//img[@src="https://iguhb7lay20b9vtl-zippykid.netdna-ssl.com/wp-content/uploads/2018/04/1_wswf9QNmKrwTB883hHb4BQ.png"]')
    end
    it "Shows all reviews for book, along with review info, title, user, rating(1-5), description" do

      visit book_path(@book_1)

      within("#review_info_#{@book_1.id}") do
        expect(page).to have_content(@review_1.title)
        expect(page).to have_content(@review_1.rating)
        expect(page).to have_content(@review_1.description)
        expect(page).to have_content(@user_1.name)
      end
    end
  end
end
