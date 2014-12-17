class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
      t.integer :picture_id
      t.integer :manager_id
      t.string :name, null: false, default: ''
      t.string :address, null: false, default: ''
      t.text :description
      t.text :google_maps_uri
      t.boolean :published, null: false, default: true
      t.timestamps
    end

    change_table :offices do |t|
      t.index :picture_id
      t.index :manager_id
      t.index :published
    end
  end
end
