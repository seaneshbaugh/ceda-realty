class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name,                   null: false, default: ''
      t.text :alt_text
      t.attachment :file
      t.string :file_fingerprint,       null: false, default: ''
      t.integer :file_original_width,   null: false, default: 1
      t.integer :file_original_height,  null: false, default: 1
      t.integer :file_medium_width,     null: false, default: 1
      t.integer :file_medium_height,    null: false, default: 1
      t.integer :file_thumbnail_width,  null: false, default: 1
      t.integer :file_thumbnail_height, null: false, default: 1
      t.timestamps
    end

    change_table :pictures do |t|
      t.index :name
      t.index :file_file_name
      t.index :file_content_type
      t.index :file_file_size
      t.index :file_fingerprint
      t.index :file_original_width
      t.index :file_original_height
      t.index :file_medium_width
      t.index :file_medium_height
      t.index :file_thumbnail_width
      t.index :file_thumbnail_height
      t.index :created_at
      t.index :updated_at
    end
  end
end
