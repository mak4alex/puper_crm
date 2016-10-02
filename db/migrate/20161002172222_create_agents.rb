class CreateAgents < ActiveRecord::Migration[5.0]
  def change
    create_table :agents do |t|
      t.string :type
      t.string :name
      t.datetime :delivery_time
      t.string :company_name
      t.integer :contact_id
      t.integer :manager_id

      t.timestamps
    end
    add_index :agents, :contact_id
    add_index :agents, :manager_id
  end
end
