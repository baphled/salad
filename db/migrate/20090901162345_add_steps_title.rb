class AddStepsTitle < ActiveRecord::Migration
  def self.up
    add_column :steps, :title, :string, :limit =>300, :null => false
  end

  def self.down
    remove_column :steps, :title
  end
end
