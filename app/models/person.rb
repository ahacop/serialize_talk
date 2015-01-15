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

  composed_of :weight,
    allow_nil: true,
    mapping: %w(weight_value pounds)

  scope :weighing_less_than, -> (weight) { where('weight_value < ?', weight.pounds) }
end
