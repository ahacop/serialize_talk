require 'rails_helper'

RSpec.describe Person, :type => :model do
  it 'serializes and deserializes name' do
    name = Name.new('Mr.', 'First', 'Middle', 'Last', 'Jr.')
    described_class.create(name: name)

    person = Person.last
    expect(person.name).to eq(name)
  end

  it 'serializes and deserializes weight' do
    weight = Weight.new(150)
    described_class.create(weight: weight)

    person = described_class.last

    expect(person.weight.pounds).to eq(150)
  end
end
