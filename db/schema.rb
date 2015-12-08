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

ActiveRecord::Schema.define(version: 20151206195840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "street"
    t.text     "address_line2"
    t.text     "city"
    t.text     "county"
    t.text     "post_code"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "allergies", force: :cascade do |t|
    t.integer  "patient_id"
    t.string   "patient_type"
    t.text     "name"
    t.date     "date_of_diagnosis"
    t.boolean  "medication"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "appointments", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.string   "description"
    t.date     "date"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "appointments", ["doctor_id", "patient_id"], name: "index_appointments_on_doctor_id_and_patient_id", using: :btree

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "mercury_images", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: :cascade do |t|
    t.text     "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
  end

  create_table "personal_health_records", force: :cascade do |t|
    t.integer  "patient_id"
    t.string   "patient_type"
    t.date     "date"
    t.text     "record_type"
    t.integer  "value"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "prescriptions", force: :cascade do |t|
    t.integer  "patient_id"
    t.string   "patient_type"
    t.time     "date"
    t.text     "drug"
    t.text     "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "test_results", force: :cascade do |t|
    t.integer  "patient_id"
    t.string   "patient_type"
    t.time     "date"
    t.text     "name"
    t.text     "results"
    t.text     "diagnosis"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "testimonials", force: :cascade do |t|
    t.text     "author"
    t.date     "date",       default: '2015-12-04'
    t.text     "body"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "user_sessions", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.text     "first_name"
    t.text     "middle_name"
    t.text     "last_name"
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.text     "phone"
    t.boolean  "patient",             default: true
    t.boolean  "doctor",              default: false
    t.boolean  "admin",               default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "receptionist",        default: false
    t.boolean  "approved",            default: false
    t.integer  "preferred_doctor_id"
    t.boolean  "locked",              default: false
    t.integer  "nhs_number"
    t.text     "title"
    t.date     "dob"
    t.text     "gender"
    t.text     "biography"
  end

  add_foreign_key "addresses", "users"
end
