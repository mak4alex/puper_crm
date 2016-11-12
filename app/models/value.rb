# == Schema Information
#
# Table name: values
#
#  id         :integer          not null, primary key
#  value      :decimal(12, 2)
#  plan_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  set_at     :datetime
#

class Value < ApplicationRecord
  belongs_to :plan

  def self.save_array(values)
    values.each do |id, value|
      Value.update(id, value: value.to_f)
    end
  end

end
