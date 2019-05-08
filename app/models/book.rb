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

  def self.avg_rating_order(order)
    joins(:reviews)
    .group(:id)
    .order("avg(reviews.rating) #{order}")
  end

  def self.sort_page_count(order)
    order(pages: :"#{order}")
  end
end
