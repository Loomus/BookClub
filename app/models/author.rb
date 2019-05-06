class Author < ApplicationRecord
  has_many :book_authors
  has_many :books, through: :book_authors

  validates_uniqueness_of :name
end
