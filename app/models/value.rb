# == Schema Information
#
# Table name: values
#
#  id         :integer          not null, primary key
#  value      :decimal(12, 2)
#  plan_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Value < ApplicationRecord
  belongs_to :plan
end
