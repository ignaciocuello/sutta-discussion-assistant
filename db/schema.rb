# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_25_024119) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "discussion_sessions", force: :cascade do |t|
    t.datetime "occurs_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["occurs_on"], name: "index_discussion_sessions_on_occurs_on", unique: true
  end

  create_table "documents", force: :cascade do |t|
    t.string "title", null: false
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "discussion_session_id", null: false
    t.index ["discussion_session_id"], name: "index_documents_on_discussion_session_id"
    t.index ["title"], name: "index_documents_on_title", unique: true
  end

  create_table "suttas", force: :cascade do |t|
    t.string "abbreviation", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "discussion_session_id", null: false
    t.index ["abbreviation"], name: "index_suttas_on_abbreviation", unique: true
    t.index ["discussion_session_id"], name: "index_suttas_on_discussion_session_id"
  end

  add_foreign_key "documents", "discussion_sessions"
  add_foreign_key "suttas", "discussion_sessions"
end
