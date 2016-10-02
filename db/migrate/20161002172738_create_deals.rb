class CreateDeals < ActiveRecord::Migration[5.0]
  def change
    create_table :deals do |t|
      t.integer :agent_id
      t.integer :currency_id
      t.string :promo
      t.string :name
      t.string :sku
      t.string :unit_type
      t.decimal :unit_price, precision: 10, scale: 2
      t.decimal :promo_unit_price, precision: 10, scale: 2
      t.string :description
      t.string :type
      t.datetime :sent_at
      t.datetime :responded_at

      t.timestamps
    end
    add_index :deals, :agent_id
    add_index :deals, :currency_id
  end
end
