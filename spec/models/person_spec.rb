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

  describe 'weight' do
    let(:weight) { Weight.new(150) }

    it 'serializes and deserializes weight' do
      described_class.create(weight: weight)

      person = described_class.last

      expect(person.weight.pounds).to eq(150)
    end

    it 'finds a person by weight' do
      person = described_class.create(weight: weight)

      expect(described_class.find_by(weight: weight)).to eq(person)
    end

    it 'finds people below a weight' do
      person = described_class.create(weight: weight)
      weight2 = Weight.new(140)
      person2 = described_class.create(weight: weight2)

      max_weight = Weight.new(160)
      expect(described_class.weighing_less_than(max_weight)).to include(person, person2)
    end
  end
end
