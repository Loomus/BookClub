require 'rails_helper'

describe User do
  describe "Relationships" do
    it {should have_many :reviews}
  end

  describe "Validations" do
    it {should validate_presence_of :name}
  end
end
