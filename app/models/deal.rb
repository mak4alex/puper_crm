# == Schema Information
#
# Table name: deals
#
#  id               :integer          not null, primary key
#  agent_id         :integer
#  currency_id      :integer
#  promo            :string
#  name             :string
#  sku              :string
#  unit_type        :string
#  unit_price       :decimal(10, 2)
#  promo_unit_price :decimal(10, 2)
#  description      :string
#  type             :string
#  sent_at          :datetime
#  responded_at     :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Deal < ApplicationRecord
  belongs_to :currency

  has_many :plans
end
