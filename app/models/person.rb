class Person < ActiveRecord::Base
  def weight
    @weight ||= Weight.new(read_attribute('weight'))
  end

  def weight=(other_weight)
    write_attribute('weight', other_weight.pounds)

    @weight = other_weight
  end
end
