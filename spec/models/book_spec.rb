require 'rails_helper'


describe Book do
  describe "Relationships" do
    it { should have_many :book_authors }
    it { should have_many(:authors).through(:book_authors)}
  end
  describe "Validations" do
    it { should validate_presence_of :title }
    it { should validate_presence_of :pages }
    it { should validate_presence_of :year }
    it { should validate_presence_of :cover_image }
  end
end
