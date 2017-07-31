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

ActiveRecord::Schema.define(version: 20170727091042) do

  create_table "album_tracks", force: :cascade do |t|
    t.integer  "album_id"
    t.integer  "track_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_album_tracks_on_album_id"
    t.index ["track_id"], name: "index_album_tracks_on_track_id"
  end

  create_table "albums", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_albums_on_title"
    t.index ["user_id"], name: "index_albums_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "comment_object_id"
    t.string   "comment_object_type"
    t.string   "content"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["comment_object_id"], name: "index_comments_on_comment_object_id"
    t.index ["comment_object_type", "comment_object_id"], name: "index_comments_on_comment_object_type_and_comment_object_id"
    t.index ["comment_object_type"], name: "index_comments_on_comment_object_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_genres_on_name", unique: true
  end

  create_table "group_users", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_groups_on_name"
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "like_object_id"
    t.string   "like_object_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["like_object_id", "like_object_type"], name: "index_likes_on_like_object_id_and_like_object_type", unique: true
    t.index ["like_object_id"], name: "index_likes_on_like_object_id"
    t.index ["like_object_type"], name: "index_likes_on_like_object_type"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.string   "title"
    t.integer  "genre_id"
    t.integer  "user_id"
    t.string   "song"
    t.string   "description"
    t.string   "image"
    t.integer  "view",        default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["genre_id"], name: "index_tracks_on_genre_id"
    t.index ["title"], name: "index_tracks_on_title"
    t.index ["user_id"], name: "index_tracks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.boolean  "admin",                  default: false
    t.string   "avatar"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index [nil], name: "index_users_on_user"
  end

end
