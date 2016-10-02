class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :step
      t.datetime :start_at
      t.datetime :end_at
      t.integer :deal_id
      t.boolean :accepted, default: false
      t.decimal :probability, precision: 4, scale: 2

      t.timestamps
    end
    add_index :plans, :deal_id
  end
end
