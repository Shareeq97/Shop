class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :project_name, null: false

      t.references :user, foreign_key: true

      t.timestamps null: false
    end
  end
end
