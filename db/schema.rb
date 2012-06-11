# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120611140416) do

  create_table "authorizations", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authorizations", ["uid"], :name => "index_authorizations_on_uid"

  create_table "services", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.string   "uname",      :null => false
    t.string   "uemail",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "services", ["user_id"], :name => "index_services_on_user_id"

  create_table "tasks", :force => true do |t|
    t.string   "title",      :limit => 100,                   :null => false
    t.string   "status",     :limit => 10,                    :null => false
    t.boolean  "active",                    :default => true, :null => false
    t.datetime "deleted_at"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.integer  "user_id",                                     :null => false
  end

  add_index "tasks", ["created_at"], :name => "index_tasks_on_created_at"
  add_index "tasks", ["status"], :name => "index_tasks_on_status"
  add_index "tasks", ["title"], :name => "index_tasks_on_title"
  add_index "tasks", ["user_id"], :name => "index_tasks_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :limit => 150, :null => false
    t.string   "password_digest",                       :null => false
    t.string   "mobile",                 :limit => 15,  :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
