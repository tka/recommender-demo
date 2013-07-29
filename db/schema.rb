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

ActiveRecord::Schema.define(version: 20130728201035) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_movies", id: false, force: true do |t|
    t.integer "category_id"
    t.integer "movie_id"
  end

  add_index "categories_movies", ["category_id"], name: "index_categories_movies_on_category_id", using: :btree
  add_index "categories_movies", ["movie_id"], name: "index_categories_movies_on_movie_id", using: :btree

  create_table "movies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "occupations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", force: true do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.float    "rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["movie_id"], name: "index_ratings_on_movie_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "gender"
    t.string   "age"
    t.integer  "occupation_id"
    t.integer  "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
