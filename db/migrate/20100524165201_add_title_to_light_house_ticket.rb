class AddTitleToLightHouseTicket < ActiveRecord::Migration
  def self.up
    add_column :lighthouse, :title, :string, :limit => 300
  end

  def self.down
    remove_column :lighthouse, :title
  end
end