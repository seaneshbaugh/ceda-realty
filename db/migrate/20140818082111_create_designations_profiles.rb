class CreateDesignationsProfiles < ActiveRecord::Migration
  def change
    create_table :designations_profiles, id: false do |t|
      t.integer :designation_id, null: false
      t.integer :profile_id, null: false
    end

    change_table :designations_profiles do |t|
      t.index :designation_id
      t.index :profile_id
      t.index [:designation_id, :profile_id], unique: true
    end
  end
end
