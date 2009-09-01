class RemoveStepTitle < ActiveRecord::Migration
  def self.up
    remove_column :steps, :title
  end

  def self.down
  end
end
