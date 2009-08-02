class CreateStepsTable < ActiveRecord::Migration
  def self.up
    create_table "steps", :force => true do |t|
      t.column :title,                      :string, :limit => 100, :null => false
    end
  end

  def self.down
    drop_table "steps"
  end
end
