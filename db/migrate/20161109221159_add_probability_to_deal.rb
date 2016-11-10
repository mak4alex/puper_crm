class AddProbabilityToDeal < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :probability, :decimal, precision: 4, scale: 2
    remove_column :plans, :probability, :decimal, precision: 4, scale: 2
  end
end
