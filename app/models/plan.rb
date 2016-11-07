# == Schema Information
#
# Table name: plans
#
#  id          :integer          not null, primary key
#  name        :string
#  step        :string
#  start_at    :datetime
#  end_at      :datetime
#  deal_id     :integer
#  accepted    :boolean          default(FALSE)
#  probability :decimal(4, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Plan < ApplicationRecord
  NAMES = %w{STRATEGIC PERSPECTIVE OPERATIONAL CURRENT IMMEDIATE}
  STEPS = %w{QUARTER MONTH DECADE}

  belongs_to :deal

  has_many :values
end
