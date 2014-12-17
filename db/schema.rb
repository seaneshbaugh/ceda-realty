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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141217211422) do

  create_table "designations", force: true do |t|
    t.integer  "picture_id"
    t.string   "name",         default: "",   null: false
    t.string   "abbreviation", default: "",   null: false
    t.text     "description"
    t.boolean  "published",    default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "designations", ["picture_id"], name: "index_designations_on_picture_id", using: :btree
  add_index "designations", ["published"], name: "index_designations_on_published", using: :btree

  create_table "designations_profiles", id: false, force: true do |t|
    t.integer "designation_id", null: false
    t.integer "profile_id",     null: false
  end

  add_index "designations_profiles", ["designation_id", "profile_id"], name: "index_designations_profiles_on_designation_id_and_profile_id", unique: true, using: :btree
  add_index "designations_profiles", ["designation_id"], name: "index_designations_profiles_on_designation_id", using: :btree
  add_index "designations_profiles", ["profile_id"], name: "index_designations_profiles_on_profile_id", using: :btree

  create_table "documents", force: true do |t|
    t.string   "name",              default: "", null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "file_fingerprint",  default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["file_fingerprint"], name: "index_documents_on_file_fingerprint", using: :btree

  create_table "offices", force: true do |t|
    t.integer  "picture_id"
    t.integer  "manager_id"
    t.string   "name",            default: "",   null: false
    t.string   "address",         default: "",   null: false
    t.text     "description"
    t.text     "google_maps_uri"
    t.boolean  "published",       default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "offices", ["manager_id"], name: "index_offices_on_manager_id", using: :btree
  add_index "offices", ["picture_id"], name: "index_offices_on_picture_id", using: :btree
  add_index "offices", ["published"], name: "index_offices_on_published", using: :btree

  create_table "pages", force: true do |t|
    t.integer  "parent_id"
    t.string   "title",            default: "",   null: false
    t.string   "slug",             default: "",   null: false
    t.string   "full_path",        default: "",   null: false
    t.text     "body"
    t.text     "style"
    t.text     "meta_description"
    t.text     "meta_keywords"
    t.boolean  "show_in_menu",     default: true, null: false
    t.boolean  "published",        default: true, null: false
    t.integer  "order",            default: 0,    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["full_path"], name: "index_pages_on_full_path", unique: true, using: :btree
  add_index "pages", ["parent_id"], name: "index_pages_on_parent_id", using: :btree
  add_index "pages", ["published"], name: "index_pages_on_published", using: :btree
  add_index "pages", ["show_in_menu"], name: "index_pages_on_show_in_menu", using: :btree
  add_index "pages", ["slug"], name: "index_pages_on_slug", using: :btree

  create_table "pictures", force: true do |t|
    t.string   "name",                  default: "", null: false
    t.text     "alt_text"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "file_fingerprint",      default: "", null: false
    t.integer  "file_original_width",   default: 0,  null: false
    t.integer  "file_original_height",  default: 0,  null: false
    t.integer  "file_medium_width",     default: 0,  null: false
    t.integer  "file_medium_height",    default: 0,  null: false
    t.integer  "file_thumbnail_width",  default: 0,  null: false
    t.integer  "file_thumbnail_height", default: 0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pictures", ["file_fingerprint"], name: "index_pictures_on_file_fingerprint", using: :btree

  create_table "posts", force: true do |t|
    t.integer  "user_id",                         null: false
    t.string   "title",            default: "",   null: false
    t.string   "slug",             default: "",   null: false
    t.text     "body"
    t.text     "style"
    t.text     "meta_description"
    t.text     "meta_keywords"
    t.boolean  "published",        default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["published"], name: "index_posts_on_published", using: :btree
  add_index "posts", ["slug"], name: "index_posts_on_slug", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "profiles", force: true do |t|
    t.integer  "user_id"
    t.integer  "picture_id"
    t.integer  "office_id"
    t.string   "slug",        default: "",   null: false
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.boolean  "published",   default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["office_id"], name: "index_profiles_on_office_id", using: :btree
  add_index "profiles", ["picture_id"], name: "index_profiles_on_picture_id", using: :btree
  add_index "profiles", ["published"], name: "index_profiles_on_published", using: :btree
  add_index "profiles", ["slug"], name: "index_profiles_on_slug", using: :btree
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "username",               default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "role",                   default: "", null: false
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role"], name: "index_users_on_role", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
