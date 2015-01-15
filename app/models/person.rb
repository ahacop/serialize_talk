class Person < ActiveRecord::Base
  serialize :weight, Weight
end
