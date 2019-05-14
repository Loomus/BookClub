require 'rails_helper'

describe Review do
  describe "Relationships" do
    it {should belong_to :book}
    it {should belong_to :user}
  end

  describe "Validations" do
    it {should validate_presence_of :title}
    it {should validate_numericality_of(:rating).is_greater_than(0).is_less_than(6)}
    it {should validate_presence_of :description}
  end
end
