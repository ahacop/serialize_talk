require 'spec_helper'
require_relative '../../app/models/name.rb'

describe Name do
  let(:person) { described_class.new('Mr.', 'First', 'Middle', 'Last', 'Jr.') }

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

  describe '#armenian?' do
    it "returns 'probably' if the name ends in 'ian'" do
      armenian_name = described_class.new('Mr.', 'Ara', '', 'Hacopian', '')
      expect(armenian_name.armenian?).to eq('probably')
    end

    it "returns 'probably not' if the name does not end in 'ian'" do
      expect(person.armenian?).to eq('probably not')
    end
  end

  describe '#==' do
    it 'returns true if the name is the same' do
      other_person = described_class.new('Mr.', 'First', 'Middle', 'Last', 'Jr.')
      expect(person).to eq(other_person)
    end

    it 'returns false if the name is different' do
      other_person = described_class.new('Mr.', 'First', 'Middle', 'Last', 'Sr.')
      expect(person).to_not eq(other_person)
    end
  end
end
