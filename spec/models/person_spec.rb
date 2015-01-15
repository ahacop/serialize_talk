require 'rails_helper'

RSpec.describe Person, :type => :model do
  describe 'name' do
    let(:name) { Name.new('Mr.', 'First', 'Middle', 'Last', 'Jr.') }

    it 'serializes and deserializes name' do
      described_class.create(name: name)

      person = Person.last

      expect(person.name).to eq(name)
    end

    it 'can find a person by name' do
      person = described_class.create(name: name)

      expect(described_class.find_by(name: name)).to eq(person)
    end
  end

  it 'serializes and deserializes weight' do
    weight = Weight.new(150)
    described_class.create(weight: weight)

    person = described_class.last

    expect(person.weight.pounds).to eq(150)
  end
end
