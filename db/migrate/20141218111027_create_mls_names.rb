class CreateMlsNames < ActiveRecord::Migration
  def change
    create_table :mls_names do |t|
      t.integer :profile_id, null: false
      t.string :name, null: false, default: ''
      t.timestamps
    end

    change_table :mls_names do |t|
      t.index :profile_id
    end
  end
end
