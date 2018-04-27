class CreateDocumentIndex < ActiveRecord::Migration[5.2]
  def change
    Document.__elasticsearch__.create_index! force: true
  end
end
