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

ActiveRecord::Schema[7.0].define(version: 2022_02_16_061552) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contents", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contents_playlists", id: false, force: :cascade do |t|
    t.bigint "playlist_id"
    t.bigint "content_id"
    t.index ["content_id"], name: "index_contents_playlists_on_content_id"
    t.index ["playlist_id"], name: "index_contents_playlists_on_playlist_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.bigint "screen_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["screen_id"], name: "index_playlists_on_screen_id"
  end

  create_table "screens", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_screens_on_event_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "auth0_uid"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth0_uid"], name: "index_users_on_auth0_uid", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "events", "users"
  add_foreign_key "playlists", "screens"
  add_foreign_key "screens", "events"
end
