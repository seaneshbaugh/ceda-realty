# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 11) do

  create_table "agent_resources", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agents", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogs", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boards", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listings", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logger_events", :force => true do |t|
    t.integer  "person_id"
    t.string   "event_type"
    t.string   "description"
    t.boolean  "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "body"
    t.string   "style"
    t.string   "meta_description"
    t.string   "meta_keywords"
    t.boolean  "top_menu"
    t.integer  "parent_id_id"
    t.integer  "display_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "salt"
    t.string   "encrypted_password"
    t.string   "cookie_code"
    t.string   "email_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "ip_addresses"
    t.integer  "privilege_level"
    t.integer  "login_count"
    t.integer  "post_count"
    t.datetime "last_login"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", :force => true do |t|
    t.string   "image_filename"
    t.string   "thumbnail_filename"
    t.string   "original_filename"
    t.string   "title"
    t.string   "caption"
    t.string   "alt_text"
    t.string   "sha2_checksum"
    t.string   "attachable_type"
    t.integer  "max_thumbnail_width"
    t.integer  "max_thumbnail_height"
    t.integer  "attachable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.integer  "person_id"
    t.string   "ip_address"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
