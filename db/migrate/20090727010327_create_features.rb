class CreateFeatures < ActiveRecord::Migration
  def self.up
    create_table "features", :force => true do |t|
      t.column :title,                      :string, :limit => 100, :null => false
      t.column :body,                       :string, :limit => 250, :null => false
    end
  end

  def self.down
    drop_table "features"
  end
end
