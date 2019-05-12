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
  describe "When I click on a user's name for any book review" do
    it "takes me to a show page for that user and show all the reviews that the user has written" do

        visit user_path(@user_1)

        expect(page).to have_content(@user_1.name)

      within("#review-#{@review_10.id}") do
        expect(page).to have_content(@book_1.title)
        expect(page).to have_xpath('//img[@src="https://iguhb7lay20b9vtl-zippykid.netdna-ssl.com/wp-content/uploads/2018/04/1_wswf9QNmKrwTB883hHb4BQ.png"]')
        expect(page).to have_content(@review_10.title)
        expect(page).to have_content(@review_10.description)
        expect(page).to have_content(@review_10.rating)
        expect(page).to have_content(@review_10.created_at)
      end
      within("#review-#{@review_4.id}") do
        expect(page).to have_content(@book_2.title)
        expect(page).to have_xpath('//img[@src="https://images.penguinrandomhouse.com/cover/9781101931288"]')
        expect(page).to have_content(@review_4.title)
        expect(page).to have_content(@review_4.description)
        expect(page).to have_content(@review_4.rating)
        expect(page).to have_content(@review_4.created_at)
      end
      within("#review-#{@review_7.id}") do
        expect(page).to have_content(@book_3.title)
        expect(page).to have_xpath('//img[@src="https://s26162.pcdn.co/wp-content/uploads/2018/08/81Ya99Bc-jL.jpg"]')
        expect(page).to have_content(@review_7.title)
        expect(page).to have_content(@review_7.description)
        expect(page).to have_content(@review_7.rating)
        expect(page).to have_content(@review_7.created_at)
      end
    end
  end

      it "has links to sort reviews by oldest and newest" do
        book_1 = Book.create!(title: "Book 1", pages: 132, year: 1973, cover_image: "www.google.com" )
        book_2 = Book.create!(title: "Book 2", pages: 474, year: 1926, cover_image: "www.yahoo.com" )
        book_3 = Book.create!(title: "Book 3", pages: 892, year: 1983, cover_image: "www.askjeeves.com" )

        user = User.create!(name: "Billy")

        review_1 = Review.create!(title: "Book 1 review", rating: 3, description: "Review for Book 1", user: user, book: book_1, created_at: 2.days.ago)
        review_2 = Review.create!(title: "Book 2 review", rating: 4, description: "Review for Book 2", user: user, book: book_2, created_at: 3.days.ago)
        review_3 = Review.create!(title: "Book 3 review", rating: 1, description: "Review for Book 3", user: user, book: book_3, created_at: 1.days.ago)

        visit user_path(user)

        within("#show-links") do
          click_link "Newest Reviews"
        end

        within("#review-list") do
          expect(page.all("p")[0]).to have_content(review_2.title)
          expect(page.all("p")[1]).to have_content("Review created at: #{review_2.created_at}")

          expect(page.all("p")[2]).to have_content(review_1.title)
          expect(page.all("p")[3]).to have_content("Review created at: #{review_1.created_at}")

          expect(page.all("p")[4]).to have_content(review_3.title)
          expect(page.all("p")[5]).to have_content("Review created at: #{review_3.created_at}")
        end

        within("#show-links") do
          click_link "Oldest Reviews"
        end

        within("#review-list") do
          expect(page.all("p")[0]).to have_content(review_3.title)
          expect(page.all("p")[1]).to have_content("Review created at: #{review_3.created_at}")

          expect(page.all("p")[2]).to have_content(review_1.title)
          expect(page.all("p")[3]).to have_content("Review created at: #{review_1.created_at}")

          expect(page.all("p")[4]).to have_content(review_2.title)
          expect(page.all("p")[5]).to have_content("Review created at: #{review_2.created_at}")
        end
      end
      describe "there is a link next to each review to delete the review" do
        it "when the link is clicked, I am returned to the user show page and the review is gone" do
          book_1 = Book.create!(title: "Book 1", pages: 132, year: 1973, cover_image: "www.google.com" )
          book_2 = Book.create!(title: "Book 2", pages: 474, year: 1926, cover_image: "www.yahoo.com" )
          book_3 = Book.create!(title: "Book 3", pages: 892, year: 1983, cover_image: "www.askjeeves.com" )

          user = User.create!(name: "Billy")

          review_1 = Review.create!(title: "Book 1 review", rating: 3, description: "Review for Book 1", user: user, book: book_1, created_at: 2.days.ago)
          review_2 = Review.create!(title: "Book 2 review", rating: 4, description: "Review for Book 2", user: user, book: book_2, created_at: 3.days.ago)
          review_3 = Review.create!(title: "Book 3 review", rating: 1, description: "Review for Book 3", user: user, book: book_3, created_at: 1.days.ago)

          visit user_path(user)

          within("#review-#{review_1.id}") do
            expect(page).to have_link("Delete Review")
          end
          within("#review-#{review_2.id}") do
            expect(page).to have_link("Delete Review")
          end
          within("#review-#{review_3.id}") do
            click_link("Delete Review")
          end
          expect(current_path).to eq(user_path(user))

          expect(page).to_not have_content(book_3.title)
          expect(page).to_not have_xpath('//img[@src="www.askjeeves.com"]')
          expect(page).to_not have_content(review_3.title)
          expect(page).to_not have_content(review_3.description)
          expect(page).to_not have_content(review_3.created_at)
        end
      end
    end
