class AddIndexToFeatures < ActiveRecord::Migration[5.2]
  def change
    add_index :features, :ticket_id, unique: true
  end
end
