class AddTypeToOffers < ActiveRecord::Migration[5.0]
  def change
    add_column :offers, :type, :string
  end
end
