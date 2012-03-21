class CreateAgentResources < ActiveRecord::Migration
  def self.up
    create_table :agent_resources do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :agent_resources
  end
end
