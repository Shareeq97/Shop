class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id, null: false 
      t.string :action, null: false
      t.references :user, foreign_key: true
      t.references :feature, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
