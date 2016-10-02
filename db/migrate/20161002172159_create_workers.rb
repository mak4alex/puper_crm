class CreateWorkers < ActiveRecord::Migration[5.0]
  def change
    create_table :workers do |t|
      t.string :full_name
      t.string :position
      t.string :phone
      t.string :email
      t.string :skype
      t.string :fax
      t.string :type

      t.timestamps
    end
    add_index :workers, :full_name, unique: true
    add_index :workers, :email, unique: true
  end
end
