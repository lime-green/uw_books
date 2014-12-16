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

ActiveRecord::Schema.define(version: 20141215203753) do

  create_table "books", force: true do |t|
    t.string   "author",               null: false
    t.string   "title",                null: false
    t.integer  "sku",        limit: 8, null: false
    t.float    "price",                null: false
    t.integer  "stock",                null: false
    t.integer  "term",                 null: false
    t.string   "department",           null: false
    t.string   "course",               null: false
    t.string   "section",              null: false
    t.string   "instructor",           null: false
    t.boolean  "reqopt",               null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
