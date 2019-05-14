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
        expect(page).to have_link(@unearthed.title)
        expect(page).to have_xpath('//img[@src="https://images.gr-assets.com/books/1495338003l/32941343.jpg"]')
        expect(page).to have_content(@unearthed.year)
        expect(page).to have_content(@unearthed.pages)
        expect(page).to have_content("Co Authored by: #{@spooner.name}")

        expect(page).to have_link(@book_2.title)
        expect(page).to have_xpath('//img[@src="https://prodimage.images-bn.com/pimages/9780547928210_p0_v2_s550x406.jpg"]')
        expect(page).to have_content(@book_2.year)
        expect(page).to have_content(@book_2.pages)

        expect(page).to have_link(@book_3.title)
        expect(page).to have_xpath('//img[@src="https://images-na.ssl-images-amazon.com/images/I/8167H8DUjnL.jpg"]')
        expect(page).to have_content(@book_3.year)
        expect(page).to have_content(@book_3.pages)
      end
    end
    it "Shows the highest rated review next to each book" do

      visit author_path(@kaufman)

      within("#author-book-info") do
        within("#book-#{@unearthed.id}") do
          expect(page).to have_link(@unearthed.title)
          expect(page).to have_content(@review_un_2.title)
          expect(page).to have_content(@review_un_2.rating)
          expect(page).to have_link(@user_2.name)
        end
      end
      within("#author-book-info") do
        within("#book-#{@book_2.id}") do
          expect(page).to have_link(@book_2.title)
          expect(page).to have_content(@review_b2_2.title)
          expect(page).to have_content(@review_b2_2.rating)
          expect(page).to have_link(@user_2.name)
        end
      end
      within("#author-book-info") do
        within("#book-#{@book_3.id}") do
          expect(page).to have_link(@book_3.title)
          expect(page).to have_content(@review_b3_2.title)
          expect(page).to have_content(@review_b3_2.rating)
          expect(page).to have_link(@user_2.name)
        end
      end
    end
    it "User can delete an author from author show page" do
      author = Author.create!(name: "Jimmy")
      book_1 = author.books.create!(title: "Book 1 for delete author", pages: 888, year: 1978, cover_image: "www.google.com")
      book_2 = author.books.create!(title: "Book 2 for delete author", pages: 885, year: 1979, cover_image: "www.yahoo.com")

      visit author_path(author)

      within("#delete") do
        click_link "Delete Author"
      end
      expect(current_path).to eq(books_path)
      expect(page).to_not have_content(author.name)
    end
    it "If author is deleted, the book is deleted" do
      author = Author.create!(name: "Jimmy")
      book_1 = Book.create!(title: "Book 1 for delete author", pages: 888, year: 1978, cover_image: "www.google.com")
      book_2 = Book.create!(title: "Book 2 for delete author", pages: 885, year: 1979, cover_image: "www.yahoo.com")
      author.books << [book_1, book_2]

      visit author_path(author)

      within("#delete") do
        click_link "Delete Author"
      end
      expect(current_path).to eq(books_path)

      expect(page).to_not have_content(author.name)

      expect(page).to_not have_content(book_1.title)
      expect(page).to_not have_content(book_1.pages)
      expect(page).to_not have_content(book_1.year)
      expect(page).to_not have_xpath('//img[@src="www.google.com"]')

      expect(page).to_not have_content(book_2.title)
      expect(page).to_not have_content(book_2.pages)
      expect(page).to_not have_content(book_2.year)
      expect(page).to_not have_xpath('//img[@src="www.yahoo.com"]')
    end

    it "If author is a coauthor for a book and author is deleted, the book is deleted and other author is deleted" do
      author = Author.create!(name: "Jimmy")
      author_2 = Author.create!(name: "Amy")
      book_1 = Book.create!(title: "Book 1 for delete author", pages: 888, year: 1978, cover_image: "www.google.com")

      author.books << book_1
      author_2.books << book_1

      visit author_path(author)

      within("#delete") do
        click_link "Delete Author"
      end
      expect(current_path).to eq(books_path)

      expect(page).to_not have_content(author.name)
      expect(page).to_not have_content(author_2.name)

      expect(page).to_not have_content(book_1.title)
      expect(page).to_not have_content(book_1.pages)
      expect(page).to_not have_content(book_1.year)
      expect(page).to_not have_xpath('//img[@src="www.google.com"]')
    end
    it "If author is a coauthor for a book and the coauthor has other books, the author and book is deleted but not ther other author" do
      author = Author.create!(name: "Jimmy")
      author_2 = Author.create!(name: "Amy")
      book_1 = Book.create!(title: "Book 1 for delete author", pages: 888, year: 1978, cover_image: "www.google.com")
      book_2 = Book.create!(title: "Should not be deleted", pages: 112, year: 1998, cover_image: "www.yahoo.com")

      author.books << book_1
      author_2.books << [book_1, book_2]

      visit author_path(author)

      within("#delete") do
        click_link "Delete Author"
      end
      expect(current_path).to eq(books_path)

      expect(page).to_not have_content(author.name)

      expect(page).to_not have_content(book_1.title)
      expect(page).to_not have_content(book_1.pages)
      expect(page).to_not have_content(book_1.year)
      expect(page).to_not have_xpath('//img[@src="www.google.com"]')

      expect(page).to have_content(author_2.name)

      expect(page).to have_content(book_2.title)
      expect(page).to have_content(book_2.pages)
      expect(page).to have_content(book_2.year)
      expect(page).to have_xpath('//img[@src="www.yahoo.com"]')
    end
  end
end
