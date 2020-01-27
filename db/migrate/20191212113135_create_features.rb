class CreateFeatures < ActiveRecord::Migration[5.2]
  def change
    create_table :features do |t|
    	t.string :category_name
      t.string :feature_name
      t.text :feature_description
      t.integer :ticket_id
      t.string :feature_status, :default => "Unstarted" 

      t.references :project, foreign_key: true
      t.references :user, foreing_key: true

      t.timestamps
    end
  end
end
