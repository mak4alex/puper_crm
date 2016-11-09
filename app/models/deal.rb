# == Schema Information
#
# Table name: deals
#
#  id               :integer          not null, primary key
#  currency_id      :integer
#  promo            :string
#  name             :string
#  sku              :string
#  unit_type        :string
#  unit_price       :decimal(10, 2)
#  promo_unit_price :decimal(10, 2)
#  description      :string
#  type             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Deal < ApplicationRecord
  TYPES = ['ClientDeal', 'SupplierDeal']
  UNIT_TYPES = ['kg', 'unit', 'l']

  attr_accessor :plan_count

  belongs_to :currency
  has_many :plans, foreign_key: :deal_id
  has_many :offers, foreign_key: :deal_id
  has_many :agents, through: :offers
end
