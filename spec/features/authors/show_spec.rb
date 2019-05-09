require 'rails_helper'

describe "Author show page" do
  describe "When i visit author_path" do
    it "I see all book titles by that author, year of publication, pages, other authors" do
      @kaufman = Author.create!(name: "Amie Kaufman")
      @spooner = Author.create!(name: "Megan Spooner")

      @unearthed = @kaufman.books.create!(title: "Unearthed", pages: 436, year: 2018, cover_image: "https://images.gr-assets.com/books/1495338003l/32941343.jpg")
      @spooner.books <<
      @book_2 = @kaufman.books.create!(title: "Unearthed 2", pages: 500, year: 2017, cover_image: "https://prodimage.images-bn.com/pimages/9780547928210_p0_v2_s550x406.jpg")
      @book_3 = @kaufman.books.create!(title: "Unearthed 3", pages: 490, year: 2019, cover_image: "https://images-na.ssl-images-amazon.com/images/I/8167H8DUjnL.jpg")

      visit author_path(@kaufman)

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
        expect(page).to have_content("Co Authored by: #{@spooner.name}")

        expect(page).to have_content(@book_3.title)
        expect(page).to have_xpath('//img[@src="https://images-na.ssl-images-amazon.com/images/I/8167H8DUjnL.jpg"]')
        expect(page).to have_content(@book_3.year)
        expect(page).to have_content(@book_3.pages)
        expect(page).to have_content("Co Authored by: #{@spooner.name}")
      end
    end
  end
end







    # User Story 14
    # Author Show Page
    #
    # As a Visitor,
    # When I visit an author's show page
    # I see all book titles by that author
    # Each book should show its year of publication
    # Each book should show its number of pages
    # Each book should show a list of any other authors
    # (exclude this show page's author from that list)
