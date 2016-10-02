class CreateValues < ActiveRecord::Migration[5.0]
  def change
    create_table :values do |t|
      t.decimal :value, precision: 12, scale: 2
      t.integer :plan_id

      t.timestamps
    end
    add_index :values, :plan_id
  end
end
