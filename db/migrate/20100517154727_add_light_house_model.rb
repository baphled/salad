class AddLightHouseModel < ActiveRecord::Migration
  def self.up
    create_table :lighthouse, :force => true do |t|
      t.column :body,                      :string, :limit => 100, :null => false
      t.column :ticket_id,                :string, :limit => 100, :null => false
    end
  end

  def self.down
    drop_table :lighthouse
  end
end
