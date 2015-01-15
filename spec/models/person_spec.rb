require 'rails_helper'

RSpec.describe Person, :type => :model do
  describe 'name methods' do
    let(:person) do
      described_class.new(
        title: 'Mr.',
        first_name: 'First',
        middle_name: 'Middle',
        last_name: 'Last',
        suffix: 'Jr.'
      )
    end

    describe '#initials' do
      it "returns the person's initials" do
        expect(person.initials).to eq('FML')
      end
    end

    describe '#full_name' do
      it "returns the person's full name" do
        expect(person.full_name).to eq('Mr. First Middle Last, Jr.')
      end
    end
  end

  it 'serializes and deserializes weight' do
    weight = Weight.new(150)
    described_class.create(weight: weight)

    person = described_class.last

    expect(person.weight.pounds).to eq(150)
  end
end
