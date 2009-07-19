class CreateProject < ActiveRecord::Migration
  def self.up
    create_table "projects", :force => true do |t|
      t.column :name,                      :string, :limit => 100, :default => '', :null => true
      t.column :description,               :string
      t.column :aim,                       :string, :limit => 250
    end
  end

  def self.down
    drop_table "projects"
  end
end
