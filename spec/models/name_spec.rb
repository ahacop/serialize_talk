require 'spec_helper'
require_relative '../../app/models/name.rb'

describe Name do
  let(:name) { described_class.new('Mr.', 'First', 'Middle', 'Last', 'Jr.') }

  describe '#initials' do
    it "returns the name's initials" do
      expect(name.initials).to eq('FML')
    end
  end

  describe '#full_name' do
    it "returns the name's full name" do
      expect(name.full_name).to eq('Mr. First Middle Last, Jr.')
    end
  end

  describe '#armenian?' do
    it "returns 'probably' if the name ends in 'ian'" do
      armenian_name = described_class.new('Mr.', 'Ara', '', 'Hacopian', '')
      expect(armenian_name.armenian?).to eq('probably')
    end

    it "returns 'probably not' if the name does not end in 'ian'" do
      expect(name.armenian?).to eq('probably not')
    end
  end

  describe 'equality' do
    let(:same_name) { described_class.new('Mr.', 'First', 'Middle', 'Last', 'Jr.') }
    let(:different_name) { described_class.new('Mr.', 'First', 'Middle', 'Last', 'Sr.') }
    subject { name }

    describe '#==' do
      it { is_expected.to eq(same_name) }
      it { is_expected.to_not eq(different_name) }
    end
  end
end
