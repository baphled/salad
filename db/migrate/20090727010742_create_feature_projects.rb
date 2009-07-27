class CreateFeatureProjects < ActiveRecord::Migration
  def self.up
    create_table :feature_projects, :id => false do |t|
      t.column :project_id, :integer, :null => false
      t.column :feature_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :feature_projects
  end
end
