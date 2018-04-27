class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :title
      t.text :description
      t.string :document_file

      t.timestamps
    end
  end
end
