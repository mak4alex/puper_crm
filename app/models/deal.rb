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

class Deal < ApplicationRecord
  TYPES = {
    client_deal: 'ClientDeal',
    supplier_deal: 'SupplierDeal'
  }

  UNIT_TYPES = {
    kg: 'kg',
    unit: 'unit',
    l: 'l'
  }

  belongs_to :currency
  has_many :plans, foreign_key: :deal_id
  has_many :offers, foreign_key: :deal_id
  has_many :agents, through: :offers

  validates :name, presence: true
  validates :sku, presence: true
  validates :unit_type, presence: true
  validates :unit_price, presence: true
  validates :description, presence: true
  validates :type, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true


  after_create do |deal|
    deal.probability ||= 0.0
    deal.accepted ||= false
    if deal.type == TYPES[:client_deal]
      [:strategic, :perspective, :operational, :current].each { |plan| create_plans(plan) }
    elsif deal.type == TYPES[:supplier_deal]
      [:strategic, :perspective, :operational, :immediate].each { |plan| create_plans(plan) }
    end
  end

  def header_dates
    dates = []
    value_set_date = self.start_at
    while value_set_date <= self.end_at do
      dates << value_set_date
      value_set_date += Plan::PERIODS[Plan::STEPS[:decade]]
    end
    dates
  end

  private

    def create_plans(plan_name)
      plan = self.plans.create(name: Plan::NAMES[plan_name])
      value_set_date = self.start_at
      while value_set_date <= self.end_at do
        plan.values.create(value: 0.0, set_at: value_set_date)
        value_set_date += Plan::PERIODS[plan.step]
      end
    end

end
