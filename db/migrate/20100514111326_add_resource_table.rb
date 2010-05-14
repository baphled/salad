class AddResourceTable < ActiveRecord::Migration
  def self.up
    create_table :resources, :force => true do |t|
      t.column :name,                      :string, :limit => 100, :null => false
      t.column :project_id,                :string, :limit => 100, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :resources
  end
end