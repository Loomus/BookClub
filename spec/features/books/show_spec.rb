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
    @user_4 = User.create!(name: "Stella")
    @user_5 = User.create!(name: "Sarah")
    @user_6 = User.create!(name: "Kristin")

    @review_2 = Review.create!(title: "review 2", rating: 4, description: "Book 1 review", user: @user_2, book: @book_1)
    @review_12 = Review.create!(title: "review 12", rating: 1, description: "Book 1 review", user: @user_6, book: @book_1)
    @review_1 = Review.create!(title: "review 1", rating: 2, description: "Book 1 review", user: @user_4, book: @book_1)
    @review_10 = Review.create!(title: "review 10", rating: 5, description: "Book 1 review", user: @user_1, book: @book_1)
    @review_3 = Review.create!(title: "review 3", rating: 1, description: "Book 1 review", user: @user_5, book: @book_1)
    @review_11 = Review.create!(title: "review 11", rating: 3, description: "Book 1 review", user: @user_3, book: @book_1)
  end

  describe "When I visit show page" do
    it "I see title, author/s page number, year published, cover image" do

      visit book_path(@book_1)

      expect(page).to have_content("#{@book_1.title} Show Page")
      expect(page).to have_content("Page Number: #{@book_1.pages}")
      expect(page).to have_content("Published In: #{@book_1.year}")
      expect(page).to have_xpath('//img[@src="https://iguhb7lay20b9vtl-zippykid.netdna-ssl.com/wp-content/uploads/2018/04/1_wswf9QNmKrwTB883hHb4BQ.png"]')
      expect(page).to have_link(@author_1.name)
      expect(page).to have_link(@author_2.name)
    end
    # I also see a list of reviews for that book.
    # Each review will have a title and user, a numeric rating
    # from 1 to 5, and text for the review itself, and all content
    # must be present for each review.
    it "Shows all reviews for book, along with review info, title, user, rating(1-5), description" do

      visit book_path(@book_1)

      within("#review_info") do
        expect(page).to have_content(@review_1.title)
        expect(page).to have_link(@user_1.name)
        expect(page).to have_content(@review_1.rating)
        expect(page).to have_content(@review_1.description)
      end
    end
    it "I see an area on the page for statistics about reviews:
        the top three reviews for this book (title, rating and user only)" do

      visit book_path(@book_1)

      within("#top_3_reviews") do
        expect(page.all("li")[0]).to have_content(@review_10.title)
        expect(page.all("li")[1]).to have_content(@review_10.rating)
        expect(page.all("li")[2]).to have_link(@user_1.name)

        expect(page.all("li")[3]).to have_content(@review_2.title)
        expect(page.all("li")[4]).to have_content(@review_2.rating)
        expect(page.all("li")[5]).to have_link(@user_2.name)

        expect(page.all("li")[6]).to have_content(@review_11.title)
        expect(page.all("li")[7]).to have_content(@review_11.rating)
        expect(page.all("li")[8]).to have_link(@user_3.name)
      end
    end
    it "show the bottom three reviews for this book (title, rating and user only)" do

      visit book_path(@book_1)

      within("#bottom_3_reviews") do

        expect(page.all("li")[0]).to have_content(@review_12.title)
        expect(page.all("li")[1]).to have_content(@review_12.rating)
        expect(page.all("li")[2]).to have_link(@user_6.name)

        expect(page.all("li")[3]).to have_content(@review_3.title)
        expect(page.all("li")[4]).to have_content(@review_3.rating)
        expect(page.all("li")[5]).to have_link(@user_5.name)

        expect(page.all("li")[6]).to have_content(@review_1.title)
        expect(page.all("li")[7]).to have_content(@review_1.rating)
        expect(page.all("li")[8]).to have_link(@user_4.name)
      end
    end

      it "shows the overall average rating of the reviews for this book" do

        visit book_path(@book_1)

        within("#average_rating") do
          expect(page).to have_content(2.7)
      end
    end

    it "has a link for a review of that book" do

      visit book_path(@book_1)

      within("#review-link") do
        click_link "Add a Review"
      end

      expect(current_path).to eq(new_book_review_path(@book_1))
    end
    it "On a book show page, there is a link to delete book, when clicked I return to index and book is gone" do
      book = Book.create!(title: "Delete Me", pages: 332, year: 1994, cover_image: "https://images-na.ssl-images-amazon.com/images/I/8167H8DUjnL.jpg")
      book.authors.create(name: "John")
      book.authors.create(name: "Jenna")

      user_1 = User.create!(name: "Jim")
      user_2 = User.create!(name: "Larry")

      review_1 = Review.create!(title: "Review 1 on book", rating: 4, description: "Book was bad", user: user_2, book: book)
      review_2 = Review.create!(title: "Review 1 on book", rating: 4, description: "Book was good", user: user_1, book: book)

      visit book_path(book)

      within("#review-link") do
        click_link "Delete Book"
      end
      expect(current_path).to eq(books_path)
      expect(page).to_not have_content(book.title)
      expect(page).to_not have_content(book.pages)
      expect(page).to_not have_content(book.year)
      expect(page).to_not have_xpath('//img[@src="https://images-na.ssl-images-amazon.com/images/I/8167H8DUjnL.jpg"]')
    end
  end
end
