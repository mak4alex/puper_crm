class AddAcceptedToDeal < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :accepted, :boolean, default: false
    remove_column :plans, :accepted, :boolean, default: false
  end
end
