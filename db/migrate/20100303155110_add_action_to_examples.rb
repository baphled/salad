class AddActionToExamples < ActiveRecord::Migration
  def self.up
    add_column :examples, :action, :string, :limit =>300, :null => false
  end

  def self.down
    remove_column :examples, :action
  end
end
