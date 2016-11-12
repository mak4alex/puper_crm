class AddAcceptedToPlan < ActiveRecord::Migration[5.0]
  def change
    add_column :values, :accepted, :boolean
  end
end
