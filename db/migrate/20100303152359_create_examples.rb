class CreateExamples < ActiveRecord::Migration
  def self.up
    create_table "examples", :force => true do |t|
      t.column :heading,                  :string, :limit => 75, :default => '', :null => false
      t.column :text,                     :string, :limit => 250, :default => '', :null => false
    end
  end

  def self.down
    drop_table "examples"
  end
end
