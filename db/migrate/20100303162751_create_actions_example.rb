class CreateActionsExample < ActiveRecord::Migration
  def self.up
    create_table :action_examples, :id => false do |t|
      t.column :action_id, :integer, :null => false
      t.column :example_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :action_examples
  end
end
