class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
    	t.string :document_file_name
	    t.string :document_content_type
	    t.string :document_file_size
	    t.datetime :document_updated_at
      t.references :feature, foreign_key: true

      t.timestamps
    end
  end
end
