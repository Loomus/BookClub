class Book < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors, dependent: :destroy

  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews

  validates_uniqueness_of :title
  validates_presence_of :pages
  validates_presence_of :year
  validates_presence_of :cover_image

  def avg_rating
    if reviews.any?
    reviews.average(:rating).round(1)
    end
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

  def top_review
    reviews.order(rating: :desc).limit(1)
  end

  def self.avg_rating_order(order)
    joins(:reviews)
    .group(:id)
    .order("avg(reviews.rating) #{order}")
  end

  def self.sort_page_count(order)
    order(pages: :"#{order}")
  end

  def self.sort_reviews(order)
    joins(:reviews)
    .group(:id)
    .order("(reviews.count) #{order}")
  end

  def self.highest_rated
    joins(:reviews)
    .group(:id)
    .order("avg(reviews.rating) desc")
    .limit(3)
  end

  def self.lowest_rated
    joins(:reviews)
    .group(:id)
    .order("avg(reviews.rating)")
    .limit(3)
  end

  def self.most_reviews
    User.joins(:reviews).order("reviews.count desc").group(:id).limit(3)
  end
end
