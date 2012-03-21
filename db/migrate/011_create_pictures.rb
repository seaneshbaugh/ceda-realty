class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.string :image_filename, :thumbnail_filename, :original_filename, :title, :caption, :alt_text, :sha2_checksum, :attachable_type
      t.integer :max_thumbnail_width, :max_thumbnail_height, :attachable_id
      t.timestamps
    end
  end

  def self.down
    drop_table :pictures
  end
end
