require 'rails_helper'

RSpec.describe Person, :type => :model do
  let(:person) { Person.new(weight: 150) }

  describe '#weight_in_pounds' do
    it "returns the person's weight in pounds" do
      expect(person.weight_in_pounds).to be(150)
    end
  end

  describe '#weight_in_kilograms' do
    it "returns the person's weight in kilograms" do
      expect(person.weight_in_kilograms).to be(68)
    end
  end

  describe '#weight_in_stone' do
    it "returns the person's weight in stone" do
      expect(person.weight_in_stone).to be(11)
    end
  end
end
