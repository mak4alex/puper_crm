class AddStartAtAndEndAtToDeal < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :start_at, :datetime
    add_column :deals, :end_at, :datetime
    remove_column :plans, :start_at, :datetime
    remove_column :plans, :end_at, :datetime
  end
end
