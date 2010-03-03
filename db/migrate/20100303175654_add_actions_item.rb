class AddActionsItem < ActiveRecord::Migration
  def self.up
    create_table "items", :force => true do |t|
      t.column :title,                  :string, :limit => 75, :default => '', :null => false
    end
  end

  def self.down
    drop_table :items
  end
end
