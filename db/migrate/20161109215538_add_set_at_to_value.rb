class AddSetAtToValue < ActiveRecord::Migration[5.0]
  def change
    add_column :values, :set_at, :datetime
  end
end
