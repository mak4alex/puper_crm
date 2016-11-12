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
  has_many :plans, foreign_key: :deal_id, dependent: :destroy
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


  def import(params)
    tmp_file = params[:file].tempfile
    destiny_path = Rails.root.join('tmp', "#{Time.now.to_i}.xlsx")
    FileUtils.move tmp_file.path, destiny_path
    imported_deal = DealXlsxService.new(destiny_path).import(params[:deal_type])

    imported_deal.plans.each do |plan|
       if ![Plan::NAMES[:strategic], Plan::NAMES[:perspective]].include?(plan.name)
         self_plan = self.plans.where(name: plan.name).first
         self_values = self_plan.values
         values = plan.values
         index = 0
         while index < values.size
           self_values[index].value +=  values[index].value
           self_values[index].save!
           index += 1
         end
       end
    end
    imported_deal.destroy
  end

  def recalc
    manager_sum = 0.0
    client_sum = 0.0
    self.plans.where(name: Plan::MANAGER_PLANS).each do |manager_plan|
      manager_plan.values.each do |manager_value|
        manager_sum += manager_value.value
        client_plan_sum = 0.0
        self.plans.where(name: Plan::CLIENT_PLANS).each do |client_plan|
          client_values =  client_plan.values.where("set_at >= ? AND set_at <= ?",
            manager_value.set_at, manager_value.set_at + Plan::PERIODS[manager_plan.step])
          client_plan_sum = client_values.map(&:value).reduce(&:+)
          client_sum += client_plan_sum.to_f
          #binding.pry
        end
        manager_value.accepted = manager_value.value.to_f >= client_plan_sum.to_f
        manager_value.save!
      end
    end
    self.probability = (manager_sum / client_sum) rescue 0.0
    self.probability = 1 if self.probability.infinite?
    self.accepted = self.probability.to_f > 0.5
    self.save!
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
