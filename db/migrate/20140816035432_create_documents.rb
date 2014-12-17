class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name, null: false, default: ''
      t.attachment :file
      t.string :file_fingerprint, null: false, default: ''
      t.timestamps
    end

    change_table :documents do |t|
      t.index :file_fingerprint
    end
  end
end
