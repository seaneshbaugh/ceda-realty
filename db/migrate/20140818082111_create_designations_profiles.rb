class CreateDesignationsProfiles < ActiveRecord::Migration
  def change
    create_table :designations_profiles do |t|
      t.integer :designation_id
      t.integer :profile_id
    end

    change_table :designations_profiles do |t|
      t.index :designation_id
        t.index :profile_id
      t.index [:designation_id, :profile_id], unique: true, name: 'index_designations_profiles_01'
    end
  end
end
