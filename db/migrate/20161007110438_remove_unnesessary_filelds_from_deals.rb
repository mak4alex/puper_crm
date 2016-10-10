class RemoveUnnesessaryFileldsFromDeals < ActiveRecord::Migration[5.0]
  def change
    remove_column :deals, :agent_id, :integer
    remove_column :deals, :sent_at, :datetime
    remove_column :deals, :responded_at, :datetime
  end
end
