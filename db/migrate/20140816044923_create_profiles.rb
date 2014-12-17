class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.integer :picture_id
      t.integer :office_id
      t.string :slug, null: false, default: ''
      t.string :name
      t.string :title
      t.text :description
      t.boolean :published, null: false, default: true
      t.timestamps
    end

    change_table :profiles do |t|
      t.index :user_id
      t.index :picture_id
      t.index :office_id
      t.index :slug
      t.index :published
    end
  end
end
