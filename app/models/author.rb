class Author < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  has_many :books, through: :book_authors, dependent: :destroy

  validates_uniqueness_of :name
end
