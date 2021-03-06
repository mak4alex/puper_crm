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
#  start_at         :datetime
#  end_at           :datetime
#  accepted         :boolean          default(FALSE)
#  probability      :decimal(4, 2)
#

class SupplierDeal < Deal
end
