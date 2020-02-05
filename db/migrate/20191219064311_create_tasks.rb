class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
    	t.string :task_name, null: false
    	t.boolean :task_completion, default: false	
    	
      t.references :feature, foreign_key: true

      t.timestamps null: false
    end
  end
end



