require 'rails_helper'

RSpec.describe Person, :type => :model do
  it 'serializes and deserializes weight' do
    weight = Weight.new(150)
    described_class.create(weight: weight)

    person = described_class.last

    expect(person.weight.pounds).to eq(150)
  end
end
