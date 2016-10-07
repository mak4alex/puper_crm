class CreateOffers < ActiveRecord::Migration[5.0]
  def change
    create_table :offers do |t|
      t.datetime :responded_at
      t.datetime :sent_at
      t.integer :agent_id
      t.integer :deal_id

      t.timestamps
    end
    add_index :offers, :agent_id
    add_index :offers, :deal_id
  end
end
