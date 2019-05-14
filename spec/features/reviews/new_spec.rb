require 'rails_helper'

describe "New review form" do
  before :each do
    @book_1 = Book.create!(title: "Book 1 title", pages: 300, year: 1992, cover_image: "https://iguhb7lay20b9vtl-zippykid.netdna-ssl.com/wp-content/uploads/2018/04/1_wswf9QNmKrwTB883hHb4BQ.png")
  end

  describe "I see a form where I can enter a review title, user name, rating, description" do
    it "when the form is submitted I am returned to show page and I see my new review, username to titlecase, username unique" do

      visit  new_book_review_path(@book_1)

      fill_in "review[title]", with: "The Fall of Gondolin"
      fill_in "review[user]", with: "David"
      fill_in "review[rating]", with: 4
      fill_in "review[description]", with: "This book is dank."
      click_button "Create Review"

      expect(current_path).to eq(book_path(@book_1))
      expect(page).to have_content("The Fall of Gondolin")
      expect(page).to have_content("David")
      expect(page).to have_content(4)
      expect(page).to have_content("This book is dank.")
    end
    it "Sad Path, if user already exists but has not reviewed a book, the review is created and user is redirected to book show page and the review is displayed" do

      user =  User.create(name: "John")

      visit  new_book_review_path(@book_1)

      fill_in "review[title]", with: "The Fall of Gondolin"
      fill_in "review[user]", with: "John"
      fill_in "review[rating]", with: 4
      fill_in "review[description]", with: "This book is dank."
      click_button "Create Review"

      expect(current_path).to eq(book_path(@book_1))
      expect(page).to have_content("The Fall of Gondolin")
      expect(page).to have_content("John")
      expect(page).to have_content(4)
      expect(page).to have_content("This book is dank.")
    end
    it "Sad Path, if user has already reviewed a book, they are redirected to form" do

      user = User.create(name: "John")
      review = @book_1.reviews.new(title: "The Fall of Gondolin", rating: 4, description: "This book is dank.")
      user.reviews << review
      review.save

      visit  new_book_review_path(@book_1)

      fill_in "review[title]", with: "The Fall of Gondolin"
      fill_in "review[user]", with: "John"
      fill_in "review[rating]", with: 4
      fill_in "review[description]", with: "This book is dank."
      click_button "Create Review"

      expect(current_path).to eq(new_book_review_path(@book_1))
    end
    it "Sad Path, if a form is incomplete, they are redirected back to form" do

      visit  new_book_review_path(@book_1)

      fill_in "review[title]", with: "The Rise of Gondolin"
      fill_in "review[user]", with: "Toby"
      fill_in "review[rating]", with: 4
      # no description filled in
      click_button "Create Review"

      expect(current_path).to eq(new_book_review_path(@book_1))
    end
    it "Sad Path, if a form is without a user, they are redirected back to form" do

      visit  new_book_review_path(@book_1)

      fill_in "review[title]", with: "The Rise of Gondolin"
      # no user filled in
      fill_in "review[rating]", with: 4
      fill_in "review[description]", with: "This book was terrible, but I would read it again."
      click_button "Create Review"

      expect(current_path).to eq(new_book_review_path(@book_1))
    end
  end
end
