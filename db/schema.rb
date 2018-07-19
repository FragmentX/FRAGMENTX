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

ActiveRecord::Schema.define(version: 20180716181427) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_restored_objects", force: :cascade do |t|
    t.integer "category_id"
    t.integer "restored_object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collections", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collections_restored_objects", force: :cascade do |t|
    t.integer "collection_id"
    t.integer "restored_object"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "compositions", force: :cascade do |t|
    t.integer "material_id"
    t.integer "restored_object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deteriorations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deteriorations_restored_objects", force: :cascade do |t|
    t.integer "deterioration_id"
    t.integer "restored_object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materials", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pieces", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "missing"
    t.string "matrix"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "restored_object_id"
    t.string "model_file_name"
    t.string "model_content_type"
    t.integer "model_file_size"
    t.datetime "model_updated_at"
    t.decimal "width"
    t.decimal "height"
    t.decimal "depth"
  end

  create_table "priorities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "protections", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "restored_objects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "category_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "author"
    t.text "classification"
    t.integer "material_id"
    t.string "technique"
    t.string "decoration"
    t.integer "units_id"
    t.decimal "width"
    t.decimal "height"
    t.decimal "depth"
    t.string "inventory_no"
    t.boolean "in_inventory"
    t.string "owner"
    t.string "deposit"
    t.string "address"
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.string "epoch"
    t.integer "state_id"
    t.integer "deterioration_id"
    t.integer "priority_id"
    t.integer "protection_id"
    t.text "notes"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer "object_type"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
