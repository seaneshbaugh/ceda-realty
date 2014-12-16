class CreateDesignations < ActiveRecord::Migration
  def change
    create_table :designations do |t|
      t.integer :picture_id
      t.string :name,         null: false, default: ''
      t.string :abbreviation, null: false, default: ''
      t.text :description
      t.boolean :published,   null: false, default: true
      t.timestamps
    end

    change_table :designations do |t|
      t.index :picture_id
      t.index :name
      t.index :abbreviation
      t.index :published
      t.index :created_at
      t.index :updated_at
    end
  end
end
