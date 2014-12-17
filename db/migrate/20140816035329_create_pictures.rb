class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name, null: false, default: ''
      t.text :alt_text
      t.attachment :file
      t.string :file_fingerprint, null: false, default: ''
      t.integer :file_original_width, null: false, default: 0
      t.integer :file_original_height, null: false, default: 0
      t.integer :file_medium_width, null: false, default: 0
      t.integer :file_medium_height, null: false, default: 0
      t.integer :file_thumbnail_width, null: false, default: 0
      t.integer :file_thumbnail_height, null: false, default: 0
      t.timestamps
    end

    change_table :pictures do |t|
      t.index :file_fingerprint
    end
  end
end
