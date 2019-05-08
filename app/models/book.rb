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

  def top_3_reviews
    reviews.order(rating: :desc).limit(3)
  end

  def bottom_3_reviews
    reviews.order(:rating).limit(3)
  end
end
