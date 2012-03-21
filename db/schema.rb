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

ActiveRecord::Schema.define(:version => 12) do

  create_table "agent_resources", :force => true do |t|
    t.text     "name"
    t.text     "description"
    t.text     "resource_filename"
    t.text     "sha2_checksum"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agents", :force => true do |t|
    t.integer  "person_id"
    t.integer  "picture_id"
    t.text     "title"
    t.text     "display_email_address"
    t.text     "display_phone_number"
    t.text     "website_url"
    t.text     "facebook_url"
    t.text     "twitter_url"
    t.text     "linked_in_url"
    t.text     "active_rain_url"
    t.text     "youtube_url"
    t.text     "bio_style"
    t.text     "bio_body"
    t.integer  "license_number"
    t.integer  "years_of_experience",   :default => 0, :null => false
    t.datetime "join_date"
    t.text     "mls_name1"
    t.text     "mls_name2"
    t.boolean  "abr_designation"
    t.boolean  "abrm_designation"
    t.boolean  "alc_designation"
    t.boolean  "cips_designation"
    t.boolean  "epro_designation"
    t.boolean  "green_designation"
    t.boolean  "gri_designation"
    t.boolean  "ahwd_designation"
    t.boolean  "repa_designation"
    t.boolean  "rsps_designation"
    t.boolean  "sres_designation"
    t.boolean  "sfr_designation"
    t.boolean  "tahs_designation"
    t.boolean  "trc_designation"
    t.boolean  "ihlm_designation"
    t.boolean  "ccim_designation"
    t.boolean  "cpm_designation"
    t.boolean  "crb_designation"
    t.boolean  "cre_designation"
    t.boolean  "crs_designation"
    t.boolean  "gaa_designation"
    t.boolean  "pmn_designation"
    t.boolean  "rce_designation"
    t.boolean  "raa_designation"
    t.boolean  "sior_designation"
    t.boolean  "ires_designation"
    t.boolean  "alhs_designation"
    t.boolean  "cdpe_designation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogs", :force => true do |t|
    t.integer  "person_id"
    t.text     "title",            :default => "", :null => false
    t.text     "body",             :default => "", :null => false
    t.text     "style"
    t.text     "meta_description"
    t.text     "meta_keywords"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boards", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "display_order"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listings", :force => true do |t|
    t.text     "street_address"
    t.text     "city"
    t.text     "state"
    t.text     "zipcode"
    t.text     "description"
    t.integer  "display_order"
    t.integer  "mls_number"
    t.integer  "price"
    t.integer  "square_feet"
    t.integer  "year_built"
    t.integer  "number_of_bedrooms"
    t.integer  "number_of_full_bathrooms"
    t.integer  "number_of_half_bathrooms"
    t.text     "acres"
    t.text     "area"
    t.text     "county"
    t.text     "neighborhood"
    t.text     "schools"
    t.text     "sub_area"
    t.text     "subdivision"
    t.text     "type"
    t.text     "alarm_security_type"
    t.text     "backyard_pool_features"
    t.text     "bedroom_2_dimensions"
    t.text     "bedroom_3_dimensions"
    t.text     "bedroom_4_dimensions"
    t.text     "bedroom_5_dimensions"
    t.text     "bed_bath_features"
    t.text     "construction"
    t.text     "construction_status"
    t.text     "directions"
    t.text     "energy_efficiency"
    t.text     "exterior_features"
    t.text     "fireplace_type"
    t.text     "flooring"
    t.text     "foundation"
    t.text     "garage_dimensions"
    t.text     "handicap_accessible"
    t.text     "heating_and_cooling"
    t.text     "hoa"
    t.text     "housing_type"
    t.text     "interior_features"
    t.text     "kitchen_equipment"
    t.text     "dollars_per_acre"
    t.text     "dollars_per_square_foot"
    t.text     "lot_description"
    t.text     "lot_size"
    t.text     "master_bedroom_dimensions"
    t.text     "master_bedroom_level"
    t.text     "fireplaces"
    t.text     "full_baths_level_1"
    t.text     "full_baths_level_2"
    t.text     "garage_spaces"
    t.text     "living_areas"
    t.text     "stories"
    t.text     "parking_garage"
    t.text     "pool"
    t.text     "possession"
    t.text     "property_also_for_lease"
    t.text     "proposed_financing"
    t.text     "roofing"
    t.text     "school_district"
    t.text     "security_system"
    t.text     "single_family_type"
    t.text     "specialty_rooms"
    t.text     "square_foot_source"
    t.text     "street_utilities"
    t.text     "study_dimensions"
    t.text     "style_of_house"
    t.text     "covered_parking_spaces"
    t.text     "type_of_fence"
    t.text     "unexempt_taxes"
    t.text     "will_subdivide"
    t.boolean  "featured_listing"
    t.text     "meta_description"
    t.text     "meta_keywords"
    t.integer  "default_picture_id"
    t.integer  "enable_slideshow",          :limit => 4, :default => 1
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
    t.text     "title"
    t.text     "body"
    t.text     "style"
    t.text     "meta_description"
    t.text     "meta_keywords"
    t.boolean  "is_index",         :default => false, :null => false
    t.boolean  "top_menu",         :default => false
    t.integer  "parent_id"
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
