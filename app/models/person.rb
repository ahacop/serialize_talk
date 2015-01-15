class Person < ActiveRecord::Base
  def weight_in_pounds
    weight
  end

  def weight_in_kilograms
    (weight * 0.453592).round
  end

  def weight_in_stone
    (weight * 0.0714286).round
  end
end
