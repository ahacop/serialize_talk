class Person < ActiveRecord::Base
  def name
    @name ||= Name.new(title, first_name, middle_name, last_name, suffix)
  end

  def name=(other_name)
    self.title = other_name.title
    self.first_name = other_name.first
    self.middle_name = other_name.middle
    self.last_name = other_name.last
    self.suffix = other_name.suffix

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
