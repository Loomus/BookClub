require 'rails_helper'

describe "New review form" do
  before :each do
    @book_1 = Book.create(title: "Book 1 title", pages: 300, year: 1992, cover_image: "https://iguhb7lay20b9vtl-zippykid.netdna-ssl.com/wp-content/uploads/2018/04/1_wswf9QNmKrwTB883hHb4BQ.png")
  end

  describe "I see a form where I can enter a review title, user name, rating, description" do
    xit "when the form is submitted I am returned to show page and I see my new review" do

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
  end
end
