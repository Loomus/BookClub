require 'rails_helper'

describe "As a visitor I see a navigation bar" do
  it "It includes a links to the home page and a link to browse all books" do

    visit '/'

    expect(current_path).to eq('/')

    expect(page).to have_link('Home')
    expect(page).to have_link('Books')

    click_link 'Home'
    expect(current_path).to eq('/')

    click_link 'Books'
    expect(current_path).to eq('/books')
  end
end
