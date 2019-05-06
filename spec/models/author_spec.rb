require 'rails_helper'

describe Author do
  describe "Relationships" do
    it { should have_many :book_authors}
    it { should have_many :books, through: :book_authors}
  end

  describe "Validations" do
    it { should validate_uniqueness_of :name }
  end
end
