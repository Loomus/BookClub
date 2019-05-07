class Book < ApplicationRecord
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews 

  validates_presence_of :title
  validates_presence_of :pages
  validates_presence_of :year
  validates_presence_of :cover_image
end
