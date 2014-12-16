class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name,             null: false, default: ''
      t.attachment :file
      t.string :file_fingerprint, null: false, default: ''
      t.timestamps
    end

    change_table :documents do |t|
      t.index :name
      t.index :file_file_name
      t.index :file_content_type
      t.index :file_file_size
      t.index :file_fingerprint
      t.index :created_at
      t.index :updated_at
    end
  end
end
