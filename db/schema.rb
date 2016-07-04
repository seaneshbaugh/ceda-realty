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

ActiveRecord::Schema.define(version: 20160704072818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "designations", force: :cascade do |t|
    t.integer  "picture_id"
    t.string   "name",         default: "",   null: false
    t.string   "abbreviation", default: "",   null: false
    t.text     "description"
    t.boolean  "published",    default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["picture_id"], name: "index_designations_on_picture_id", using: :btree
    t.index ["published"], name: "index_designations_on_published", using: :btree
  end

  create_table "designations_profiles", id: false, force: :cascade do |t|
    t.integer "designation_id", null: false
    t.integer "profile_id",     null: false
    t.index ["designation_id", "profile_id"], name: "index_designations_profiles_on_designation_id_and_profile_id", unique: true, using: :btree
    t.index ["designation_id"], name: "index_designations_profiles_on_designation_id", using: :btree
    t.index ["profile_id"], name: "index_designations_profiles_on_profile_id", using: :btree
  end

  create_table "documents", force: :cascade do |t|
    t.string   "name",              default: "", null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "file_fingerprint",  default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["file_fingerprint"], name: "index_documents_on_file_fingerprint", using: :btree
  end

  create_table "mls_names", force: :cascade do |t|
    t.integer  "profile_id",              null: false
    t.string   "name",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["profile_id"], name: "index_mls_names_on_profile_id", using: :btree
  end

  create_table "offices", force: :cascade do |t|
    t.integer  "picture_id"
    t.integer  "manager_id"
    t.string   "name",               default: "",   null: false
    t.string   "slug",               default: "",   null: false
    t.string   "street_address_1",   default: "",   null: false
    t.string   "street_address_2",   default: "",   null: false
    t.string   "city",               default: "",   null: false
    t.string   "state",              default: "",   null: false
    t.string   "zipcode",            default: "",   null: false
    t.string   "phone_number",       default: "",   null: false
    t.string   "fax_number",         default: "",   null: false
    t.text     "description_body"
    t.text     "description_style"
    t.text     "description_script"
    t.text     "google_maps_uri"
    t.boolean  "published",          default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["manager_id"], name: "index_offices_on_manager_id", using: :btree
    t.index ["picture_id"], name: "index_offices_on_picture_id", using: :btree
    t.index ["published"], name: "index_offices_on_published", using: :btree
    t.index ["slug"], name: "index_offices_on_slug", unique: true, using: :btree
  end

  create_table "pages", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "title",            default: "",    null: false
    t.string   "slug",             default: "",    null: false
    t.string   "full_path",        default: "",    null: false
    t.text     "body"
    t.text     "style"
    t.text     "script"
    t.text     "meta_description"
    t.text     "meta_keywords"
    t.boolean  "show_in_menu",     default: true,  null: false
    t.boolean  "published",        default: true,  null: false
    t.integer  "order",            default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_home",          default: false, null: false
    t.index ["full_path"], name: "index_pages_on_full_path", unique: true, using: :btree
    t.index ["is_home"], name: "index_pages_on_is_home", using: :btree
    t.index ["parent_id"], name: "index_pages_on_parent_id", using: :btree
    t.index ["published"], name: "index_pages_on_published", using: :btree
    t.index ["show_in_menu"], name: "index_pages_on_show_in_menu", using: :btree
    t.index ["slug"], name: "index_pages_on_slug", using: :btree
  end

  create_table "pictures", force: :cascade do |t|
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
    t.index ["file_fingerprint"], name: "index_pictures_on_file_fingerprint", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id",                         null: false
    t.string   "title",            default: "",   null: false
    t.string   "slug",             default: "",   null: false
    t.text     "body"
    t.text     "style"
    t.text     "script"
    t.text     "meta_description"
    t.text     "meta_keywords"
    t.boolean  "published",        default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["published"], name: "index_posts_on_published", using: :btree
    t.index ["slug"], name: "index_posts_on_slug", unique: true, using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "picture_id"
    t.integer  "office_id"
    t.string   "slug",                  default: "",   null: false
    t.string   "display_name"
    t.string   "title"
    t.string   "display_email_address"
    t.string   "phone_number"
    t.string   "website_uri"
    t.string   "facebook_uri"
    t.string   "twitter_username"
    t.string   "linked_in_uri"
    t.string   "active_rain_uri"
    t.string   "youtube_uri"
    t.string   "instagram_uri"
    t.text     "bio_body"
    t.text     "bio_style"
    t.text     "bio_script"
    t.string   "license_number"
    t.integer  "years_of_experience"
    t.date     "joined_at"
    t.boolean  "published",             default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["office_id"], name: "index_profiles_on_office_id", using: :btree
    t.index ["picture_id"], name: "index_profiles_on_picture_id", using: :btree
    t.index ["published"], name: "index_profiles_on_published", using: :btree
    t.index ["slug"], name: "index_profiles_on_slug", unique: true, using: :btree
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",               default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

end
