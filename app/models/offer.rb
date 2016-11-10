# == Schema Information
#
# Table name: offers
#
#  id           :integer          not null, primary key
#  responded_at :datetime
#  sent_at      :datetime
#  agent_id     :integer
#  deal_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  type         :string
#

class Offer < ApplicationRecord
  after_initialize :set_default_values

  belongs_to :deal
  belongs_to :agent

  def set_default_values
    self.sent_at ||= Time.now
  end
  
end
