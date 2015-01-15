class Person < ActiveRecord::Base
  composed_of :name,
    allow_nil: true,
    mapping: {
      title: :title,
      first_name: :first,
      middle_name: :middle,
      last_name: :last,
      suffix: :suffix
    }

  def weight
    @weight ||= Weight.new(weight_value)
  end

  def weight=(other_weight)
    self.weight_value = other_weight.pounds

    @weight = other_weight
  end
end
