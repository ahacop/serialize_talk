class Person < ActiveRecord::Base
  def initials
    first_name.chr + middle_name.chr + last_name.chr
  end

  def full_name
    "#{title} #{first_name} #{middle_name} #{last_name}, #{suffix}"
  end

  def weight
    @weight ||= Weight.new(weight_value)
  end

  def weight=(other_weight)
    self.weight_value = other_weight.pounds

    @weight = other_weight
  end
end
