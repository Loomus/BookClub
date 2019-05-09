require 'rails_helper'

describe "Author show page" do
  before :each do
    @kaufman = Author.create!(name: "Amie Kaufman")
    @spooner = Author.create!(name: "Megan Spooner")

    @user_1 = User.create!(name: "Larry")
    @user_2 = User.create!(name: "Marie")
    @user_3 = User.create!(name: "Josie Wales")

    @unearthed = @kaufman.books.create!(title: "Unearthed", pages: 436, year: 2018, cover_image: "https://images.gr-assets.com/books/1495338003l/32941343.jpg")
    @spooner.books << @unearthed

      @review_un_1 = Review.create!(title: "review of unearthed 1", rating: 3, description: "This was a great book.", book: @unearthed, user: @user_1)
      @review_un_2 = Review.create!(title: "review of unearthed 2", rating: 5, description: "This was a pretty good book.", book: @unearthed, user: @user_2)
      @review_un_3 = Review.create!(title: "review of unearthed 3", rating: 4, description: "This was an average book.", book: @unearthed, user: @user_3)

    @book_2 = @kaufman.books.create!(title: "Unearthed 2", pages: 500, year: 2017, cover_image: "https://prodimage.images-bn.com/pimages/9780547928210_p0_v2_s550x406.jpg")

      @review_b2_1 = Review.create!(title: "book 2 review 1", rating: 3, description: "This was a great read", book: @book_2, user: @user_1)
      @review_b2_2 = Review.create!(title: "book 2 review 2", rating: 5, description: "This was a good read", book: @book_2, user: @user_2)
      @review_b2_3 = Review.create!(title: "book 2 review 3", rating: 4, description: "This was an ok read", book: @book_2, user: @user_3)

    @book_3 = @kaufman.books.create!(title: "Unearthed 3", pages: 490, year: 2019, cover_image: "https://images-na.ssl-images-amazon.com/images/I/8167H8DUjnL.jpg")

      @review_b3_1 = Review.create!(title: "book 3 review 1", rating: 3, description: "Very good book indeed", book: @book_3, user: @user_1)
      @review_b3_2 = Review.create!(title: "book 3 review 1", rating: 5, description: "Very good book indeed", book: @book_3, user: @user_2)
      @review_b3_3 = Review.create!(title: "book 3 review 1", rating: 4, description: "Very good book indeed", book: @book_3, user: @user_3)

  end
  describe "When i visit author_path" do
    it "I see all book titles by that author, year of publication, pages, other authors" do

      visit author_path(@kaufman)

      expect(page).to have_content(@kaufman.name)

      within("#author-book-info") do
        expect(page).to have_content(@unearthed.title)
        expect(page).to have_xpath('//img[@src="https://images.gr-assets.com/books/1495338003l/32941343.jpg"]')
        expect(page).to have_content(@unearthed.year)
        expect(page).to have_content(@unearthed.pages)
        expect(page).to have_content("Co Authored by: #{@spooner.name}")

        expect(page).to have_content(@book_2.title)
        expect(page).to have_xpath('//img[@src="https://prodimage.images-bn.com/pimages/9780547928210_p0_v2_s550x406.jpg"]')
        expect(page).to have_content(@book_2.year)
        expect(page).to have_content(@book_2.pages)

        expect(page).to have_content(@book_3.title)
        expect(page).to have_xpath('//img[@src="https://images-na.ssl-images-amazon.com/images/I/8167H8DUjnL.jpg"]')
        expect(page).to have_content(@book_3.year)
        expect(page).to have_content(@book_3.pages)
      end
    end
    it "Shows the highest rated review next to each book" do

      visit author_path(@kaufman)

      within("#author-book-info") do
        within("#book-#{@unearthed.id}") do
          expect(page).to have_content(@unearthed.title)
          expect(page).to have_content(@review_un_2.title)
          expect(page).to have_content(@review_un_2.rating)
          expect(page).to have_content(@user_2.name)
        end
      end
      within("#author-book-info") do
        within("#book-#{@book_2.id}") do
          expect(page).to have_content(@book_2.title)
          expect(page).to have_content(@review_b2_2.title)
          expect(page).to have_content(@review_b2_2.rating)
          expect(page).to have_content(@user_2.name)
        end
      end
      within("#author-book-info") do
        within("#book-#{@book_3.id}") do
          expect(page).to have_content(@book_3.title)
          expect(page).to have_content(@review_b3_2.title)
          expect(page).to have_content(@review_b3_2.rating)
          expect(page).to have_content(@user_2.name)
        end
      end
    end
  end
end
