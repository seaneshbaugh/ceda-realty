class AddIsHomeToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :is_home, :boolean, null: false, default: false

    change_table :pages do |t|
      t.index :is_home
    end
  end
end
