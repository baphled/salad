class RemoveTextAndActionFromExamples < ActiveRecord::Migration
  def self.up
    remove_column :examples, :action
    remove_column :examples, :text
  end

  def self.down
  end
end
