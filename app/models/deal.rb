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

  belongs_to :currency
  has_many :plans
end
