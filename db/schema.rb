# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090730111557) do

  create_table "feature_projects", :id => false, :force => true do |t|
    t.integer "project_id", :null => false
    t.integer "feature_id", :null => false
  end

  create_table "features", :force => true do |t|
    t.string "title", :limit => 100, :null => false
    t.string "body",  :limit => 250, :null => false
  end

  create_table "projects", :force => true do |t|
    t.string "description"
    t.string "aim",         :limit => 250
    t.string "title"
  end

  create_table "stories", :force => true do |t|
    t.string "title",    :limit => 100, :null => false
    t.string "scenario", :limit => 250, :null => false
  end

end
