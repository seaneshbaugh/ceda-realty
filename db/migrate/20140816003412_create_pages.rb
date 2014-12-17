class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :parent_id
      t.string :title, null: false, default: ''
      t.string :slug, null: false, default: ''
      t.string :full_path, null: false, default: ''
      t.text :body
      t.text :style
      t.text :meta_description
      t.text :meta_keywords
      t.boolean :show_in_menu, null: false, default: true
      t.boolean :published, null: false, default: true
      t.integer :order, null: false, default: 0
      t.timestamps
    end

    change_table :pages do |t|
      t.index :parent_id
      t.index :slug
      t.index :full_path, unique: true
      t.index :show_in_menu
      t.index :published
    end
  end
end
