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

ActiveRecord::Schema.define(version: 2019_12_26_184642) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "candidate_formations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "candidate_profiles", force: :cascade do |t|
    t.string "name"
    t.string "nickname"
    t.date "date_of_birth"
    t.integer "candidate_formation_id"
    t.text "description"
    t.text "experience"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "candidate_id"
    t.index ["candidate_formation_id"], name: "index_candidate_profiles_on_candidate_formation_id"
    t.index ["candidate_id"], name: "index_candidate_profiles_on_candidate_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_candidates_on_email", unique: true
    t.index ["reset_password_token"], name: "index_candidates_on_reset_password_token", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.integer "candidate_id"
    t.integer "head_hunter_id"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_comments_on_candidate_id"
    t.index ["head_hunter_id"], name: "index_comments_on_head_hunter_id"
  end

  create_table "experience_levels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "head_hunters", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_head_hunters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_head_hunters_on_reset_password_token", unique: true
  end

  create_table "hiring_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "skills_description"
    t.decimal "salary", precision: 8, scale: 2
    t.integer "experience_level_id"
    t.integer "hiring_type_id"
    t.string "address"
    t.integer "home_office", default: 0
    t.date "registration_end_date"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "head_hunter_id"
    t.index ["experience_level_id"], name: "index_jobs_on_experience_level_id"
    t.index ["head_hunter_id"], name: "index_jobs_on_head_hunter_id"
    t.index ["hiring_type_id"], name: "index_jobs_on_hiring_type_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "candidate_id"
    t.integer "job_id"
    t.text "candidate_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_subscriptions_on_candidate_id"
    t.index ["job_id"], name: "index_subscriptions_on_job_id"
  end

end
