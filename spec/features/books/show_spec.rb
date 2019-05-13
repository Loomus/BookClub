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
      expect(page).to have_link(@book_1.title)
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
    it "I see an area on the page for statistics about reviews:
        the top three reviews for this book (title, rating and user only)" do

      visit book_path(@book_1)

      within("#top_3_reviews_#{@book_1.id}") do
        expect(page).to have_content(@review_10.title)
        expect(page).to have_content(@review_10.rating)
        expect(page).to have_content(@user_1.name)

        expect(page).to have_content(@review_2.title)
        expect(page).to have_content(@review_2.rating)
        expect(page).to have_content(@user_2.name)

        expect(page).to have_content(@review_11.title)
        expect(page).to have_content(@review_11.rating)
        expect(page).to have_content(@user_3.name)
      end
    end
    it "show the bottom three reviews for this book (title, rating and user only)" do

      visit book_path(@book_1)

      within("#bottom_3_reviews_#{@book_1.id}") do

        expect(page).to have_content(@review_3.title)
        expect(page).to have_content(@review_3.rating)
        expect(page).to have_content(@user_5.name)

        expect(page).to have_content(@review_1.title)
        expect(page).to have_content(@review_1.rating)
        expect(page).to have_content(@user_4.name)

        expect(page).to have_content(@review_12.title)
        expect(page).to have_content(@review_12.rating)
        expect(page).to have_content(@user_6.name)
      end
    end

      it "shows the overall average rating of the reviews for this book" do

        visit book_path(@book_1)

        within("#average_rating_#{@book_1.id}") do
          expect(page).to have_content(@book_1.avg_rating)
      end
    end

    it "has a link for a review of that book" do

      visit book_path(@book_1)

      within("#review-link") do
        click_link "Add a Review"
      end

      expect(current_path).to eq(new_book_review_path(@book_1))
    end
  end
end


  #     As a Visitor,
  # When I visit a book's show page
  # I see a link to add a new review for this book.
  # When I click on this link, I am taken to a new review path.
  # On this new page, I see a form where I can enter:
  # - a review title
  # - a username as a string
  # - a numeric rating that can only be a number from 1 to 5
  # - some text for the review itself
  # When the form is submitted, I should return to that book's
  # show page and I should see my review text.
  #
  # User names should be converted to Title Case before saving.
  # User names should be unique for that book (a user can leave only one review per book)
  # Checklist:
  #   base code tests are written
  #   base code is written to pass tests
  #   edge case ("sad path") tests written
  #   edge case code written
  #   code is reviewed
  #   branch is merged
  #   all tests still pass
