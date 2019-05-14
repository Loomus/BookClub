class Review < ApplicationRecord

  belongs_to :book
  belongs_to :user

  validates_presence_of :title
  validates_numericality_of :rating, greater_than: 0, less_than: 6
  validates_presence_of :description

end
