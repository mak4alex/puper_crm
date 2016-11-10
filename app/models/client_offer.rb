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

class ClientOffer < Offer
end
