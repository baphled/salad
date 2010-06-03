class IncreaseTicketBodyLength < ActiveRecord::Migration
  def self.up
    change_column :lighthouse, :body, :string, :limit => 255
  end

  def self.down
    change_column :lighthouse, :body, :string, :limit => 100
  end
end