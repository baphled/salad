class AddActionsItemsAssociation < ActiveRecord::Migration
  def self.up
    create_table :action_items, :id => false do |t|
      t.column :action_id, :integer, :null => false
      t.column :item_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :action_items
  end
end
