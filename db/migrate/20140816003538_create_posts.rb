class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id,      null: false
      t.string :title,         null: false, default: ''
      t.string :slug,          null: false, default: ''
      t.text :body
      t.text :style
      t.text :meta_description
      t.text :meta_keywords
      t.boolean :published,    null: false, default: true
      t.timestamps
    end

    change_table :posts do |t|
      t.index :user_id
      t.index :title
      t.index :slug
      t.index :published
      t.index :created_at
      t.index :updated_at
    end
  end
end
