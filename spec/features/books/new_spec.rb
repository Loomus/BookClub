require 'rails_helper'

describe "As a visitor" do
  describe "new book form" do
    it "fill in form, create a new book, and author/s titleize name and title if lowercase, cover image has a default picture" do

      visit new_book_path

      fill_in "book[title]", with: "new book"
      fill_in "book[pages]", with: 334
      fill_in "book[year]", with: 1992
      fill_in "book[cover_image]", with: "https://vignette.wikia.nocookie.net/books-turn-to-movies/images/3/3e/Harry-Potter-and-the-Deathly-Hallows-Part-1.jpg/revision/latest?cb=20160321001722"
      fill_in "book[authors]", with: "arya, joey"

      click_on "Create Book"

      new_book = Book.last

      expect(current_path).to eq(book_path(new_book))

      expect(page).to have_content("New Book")
      expect(page).to have_content(new_book.pages)
      expect(page).to have_xpath('//img[@src="https://vignette.wikia.nocookie.net/books-turn-to-movies/images/3/3e/Harry-Potter-and-the-Deathly-Hallows-Part-1.jpg/revision/latest?cb=20160321001722"]')
      expect(page).to have_content("Arya")
      expect(page).to have_content("Joey")
    end
    it "if a form is filled in with existing book title, user is redirected to the form" do

      book = Book.create!(title: "Existing Book", pages: 123, year: 1990, cover_image: "https://vignette.wikia.nocookie.net/books-turn-to-movies/images/3/3e/Harry-Potter-and-the-Deathly-Hallows-Part-1.jpg/revision/latest?cb=20160321001722")

      author = book.authors.create!(name: "Riceroni")

      visit new_book_path

      fill_in "book[title]", with: "Existing Book"
      fill_in "book[pages]", with: 123
      fill_in "book[year]", with: 1990
      fill_in "book[cover_image]", with: "https://vignette.wikia.nocookie.net/books-turn-to-movies/images/3/3e/Harry-Potter-and-the-Deathly-Hallows-Part-1.jpg/revision/latest?cb=20160321001722"
      fill_in "book[authors]", with: "Riceroni"

      click_on "Create Book"


      expect(current_path).to eq(new_book_path)
    end
    it "if a form is filled in with a single author, it allows book to be created" do

      book = Book.create!(title: "Book about books", pages: 123, year: 1990, cover_image: "https://vignette.wikia.nocookie.net/books-turn-to-movies/images/3/3e/Harry-Potter-and-the-Deathly-Hallows-Part-1.jpg/revision/latest?cb=20160321001722")

      author = book.authors.create!(name: "Riceroni")

      visit new_book_path

      fill_in "book[title]", with: "Book about books"
      fill_in "book[pages]", with: 123
      fill_in "book[year]", with: 1990
      fill_in "book[cover_image]", with: "https://vignette.wikia.nocookie.net/books-turn-to-movies/images/3/3e/Harry-Potter-and-the-Deathly-Hallows-Part-1.jpg/revision/latest?cb=20160321001722"
      fill_in "book[authors]", with: "Riceroni"

      click_on "Create Book"

      new_book = Book.last

      expect(current_path).to eq(book_path(new_book))

      expect(page).to have_content("Book About Books")
      expect(page).to have_content(new_book.pages)
      expect(page).to have_xpath('//img[@src="https://vignette.wikia.nocookie.net/books-turn-to-movies/images/3/3e/Harry-Potter-and-the-Deathly-Hallows-Part-1.jpg/revision/latest?cb=20160321001722"]')
      expect(page).to have_content("Riceroni")
    end
    it "if a form is filled in without a cover_image, a default image is set" do

      book = Book.create!(title: "Book about books", pages: 123, year: 1990, cover_image: "https://vignette.wikia.nocookie.net/books-turn-to-movies/images/3/3e/Harry-Potter-and-the-Deathly-Hallows-Part-1.jpg/revision/latest?cb=20160321001722")

      author = book.authors.create!(name: "Riceroni")

      visit new_book_path

      fill_in "book[title]", with: "Book about books"
      fill_in "book[pages]", with: 123
      fill_in "book[year]", with: 1990
      # fill_in "book[cover_image]", with: "https://vignette.wikia.nocookie.net/books-turn-to-movies/images/3/3e/Harry-Potter-and-the-Deathly-Hallows-Part-1.jpg/revision/latest?cb=20160321001722"
      fill_in "book[authors]", with: "Riceroni"

      click_on "Create Book"

      new_book = Book.last

      expect(current_path).to eq(book_path(new_book))

      expect(page).to have_content("Book About Books")
      expect(page).to have_content(new_book.pages)
      expect(page).to have_xpath('//img[@src="https://ibf.org/site_assets/img/placeholder-book-cover-default.png"]')
      expect(page).to have_content("Riceroni")
    end
  end
end
# and each author will be added to the database.
# Authors added to the database should have their names converted
# to Title Case.
# Author Names should be unique within the system.
