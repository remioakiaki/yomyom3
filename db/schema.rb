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

ActiveRecord::Schema.define(version: 2020_05_06_051953) do

  create_table "books", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "image_url"
    t.string "isbn"
    t.string "publishername"
    t.string "rakuten_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookshelves", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "image_url"
    t.string "isbn"
    t.string "publishername"
    t.string "rakuten_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.bigint "micropost_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["micropost_id"], name: "index_comments_on_micropost_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_likes_on_book_id"
    t.index ["user_id", "book_id"], name: "index_likes_on_user_id_and_book_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "microposts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content"
    t.string "title"
    t.string "picture"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "rate"
    t.bigint "book_id"
    t.json "pictures"
    t.index ["book_id"], name: "index_microposts_on_book_id"
    t.index ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_microposts_on_user_id"
  end

  create_table "records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "yyyymmdd"
    t.time "hhmm"
    t.bigint "user_id"
    t.bigint "bookshelf_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "page_amount", default: 0
    t.integer "minutes", default: 0
    t.integer "hours", default: 0
    t.index ["bookshelf_id"], name: "index_records_on_bookshelf_id"
    t.index ["user_id"], name: "index_records_on_user_id"
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_bookshelves", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "bookshelf_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "status_id", default: 1
    t.index ["bookshelf_id"], name: "index_user_bookshelves_on_bookshelf_id"
    t.index ["status_id"], name: "index_user_bookshelves_on_status_id"
    t.index ["user_id"], name: "index_user_bookshelves_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.string "picture"
    t.text "introduce"
    t.boolean "admin"
  end

  add_foreign_key "comments", "microposts"
  add_foreign_key "comments", "users"
  add_foreign_key "likes", "books"
  add_foreign_key "likes", "users"
  add_foreign_key "microposts", "books"
  add_foreign_key "microposts", "users"
  add_foreign_key "records", "bookshelves"
  add_foreign_key "records", "users"
  add_foreign_key "user_bookshelves", "bookshelves"
  add_foreign_key "user_bookshelves", "statuses"
  add_foreign_key "user_bookshelves", "users"
end
