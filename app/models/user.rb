class User < ApplicationRecord
  has_many :reviews
  has_many :books, through: :reviews
  validates_presence_of :name

  def self.most_reviews
    joins(:reviews).order("reviews.count desc").group(:id).limit(3)
  end

  def sort_review_date(order)
    reviews.order(created_at: :"#{order}")
  end
end
