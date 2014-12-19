class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.integer :picture_id
      t.integer :office_id
      t.string :slug, null: false, default: ''
      t.string :display_name
      t.string :title
      t.string :display_email_address
      t.string :phone_number
      t.string :website_uri
      t.string :facebook_uri
      t.string :twitter_username
      t.string :linked_in_uri
      t.string :active_rain_uri
      t.string :youtube_uri
      t.string :instagram_uri
      t.text :bio_body
      t.text :bio_style
      t.text :bio_script
      t.string :license_number
      t.integer :years_of_experience
      t.date :joined_at
      t.boolean :published, null: false, default: true
      t.timestamps
    end

    change_table :profiles do |t|
      t.index :user_id
      t.index :picture_id
      t.index :office_id
      t.index :slug, unique: true
      t.index :published
    end
  end
end
