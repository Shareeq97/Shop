class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.string :action 
      t.references :user, foreign_key: true
      t.references :feature, foreign_key: true
      t.timestamps
    end
  end
end
