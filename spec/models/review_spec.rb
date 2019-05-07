require 'rails_helper'

describe Review do
  describe "Relationships" do
    it {should belong_to :book}
    it {should belong_to :user}
  end

  describe "Validations" do
    it {should validate_presence_of :title}
    it {should validate_presence_of :rating}
    it {should validate_presence_of :description}
  end
end
