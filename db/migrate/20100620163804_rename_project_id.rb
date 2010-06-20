class RenameProjectId < ActiveRecord::Migration
  def self.up
    rename_column(:resources, 'project_id', 'project')
  end

  def self.down
    rename_column(:resources, 'project', 'project_id')
  end
end
