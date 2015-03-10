require 'spec_helper'
require_relative '../../app/models/weight.rb'

describe Weight do
  let(:weight) { described_class.new(150) }

  describe '#weight_in_pounds' do
    it "returns the person's weight in pounds" do
      expect(weight.pounds).to be(150)
    end
  end

  describe '#weight_in_kilograms' do
    it "returns the person's weight in kilograms" do
      expect(weight.kilograms).to be(68)
    end
  end

  describe '#weight_in_stone' do
    it "returns the person's weight in stone" do
      expect(weight.stone).to be(11)
    end
  end

  describe '#<=>' do
    subject { weight }

    context 'the other weight is less than' do
      let(:other_weight) { Weight.new(100) }

      it { is_expected.to be > other_weight }
      it { is_expected.to_not be < other_weight }
      it { is_expected.to_not eq(other_weight) }
    end

    context 'the other weight is greater than' do
      let(:other_weight) { Weight.new(200) }

      it { is_expected.to be < other_weight }
      it { is_expected.to_not be > other_weight }
      it { is_expected.to_not eq(other_weight) }
    end

    context 'the other weight is equal' do
      it { is_expected.to eq(Weight.new(150)) }
    end
  end

  it "uniq's an array of weights properly" do
    weights = 3.times.map { weight.dup }
    expect(weights.uniq).to contain_exactly(weight.dup)
  end
end
