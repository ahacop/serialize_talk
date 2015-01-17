class Person < ActiveRecord::Base
  def name
    @name ||= Name.new(*name_fields.values)
  end

  def name=(other_name)
    self.name_fields = {
      title: other_name.title,
      first_name: other_name.first,
      middle_name: other_name.middle,
      last_name: other_name.last,
      suffix: other_name.suffix
    }

    @name = other_name
  end

  def weight
    @weight ||= Weight.new(weight_value)
  end

  def weight=(other_weight)
    self.weight_value = other_weight.pounds

    @weight = other_weight
  end
end
