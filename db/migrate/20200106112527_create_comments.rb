class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|

    	t.string :comment_name

      t.references :feature, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps null: false
    end
  end
end
