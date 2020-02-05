class CreateFeatures < ActiveRecord::Migration[5.2]
  def change
    create_table :features do |t|
    	t.string :category_name, null: false
      t.string :feature_name, null: false
      t.text :feature_description
      t.integer :ticket_id, null: false
      t.string :feature_status, default: "Unstarted" 

      t.references :project, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps null: false
    end
  end
end
