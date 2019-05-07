class Book < ApplicationRecord
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews

  validates_presence_of :title
  validates_presence_of :pages
  validates_presence_of :year
  validates_presence_of :cover_image

  def avg_rating
    reviews.average(:rating)
  end

  def review_count
    reviews.count
  end

  def self.sort_rating(order)
    joins(:reviews).select("AVG(reviews.rating) AS book_review").group(:id).order(book_review: "#{order}")
  end
end
