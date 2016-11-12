# == Schema Information
#
# Table name: plans
#
#  id         :integer          not null, primary key
#  name       :string
#  step       :string
#  deal_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Plan < ApplicationRecord

  NAMES = {
    strategic: 'STRATEGIC',
    perspective: 'PERSPECTIVE',
    operational: 'OPERATIONAL',
    current: 'CURRENT',
    immediate: 'IMMEDIATE'
  }

  MANAGER_PLANS = [Plan::NAMES[:strategic], Plan::NAMES[:perspective]]
  CLIENT_PLANS = [Plan::NAMES[:operational], Plan::NAMES[:current], Plan::NAMES[:immediate]]

  STEPS = {
    quater: 'QUARTER',
    month: 'MONTH',
    decade: 'DECADE'
  }

  PERIODS = {
    'QUARTER' => 120.days,
    'MONTH' => 30.days,
    'DECADE' => 10.days
  }

  belongs_to :deal
  has_many :values, dependent: :destroy

  before_create do |plan|
    if plan.name == NAMES[:strategic]
      plan.step = STEPS[:quater]
    elsif plan.name == NAMES[:perspective]
      plan.step = STEPS[:month]
    else
      plan.step = STEPS[:decade]
    end
  end

end
