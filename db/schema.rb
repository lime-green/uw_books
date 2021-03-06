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

ActiveRecord::Schema.define(version: 20141220204354) do

  create_table "books", force: true do |t|
    t.string   "author",     null: false
    t.string   "title",      null: false
    t.string   "sku",        null: false
    t.float    "price",      null: false
    t.integer  "stock",      null: false
    t.boolean  "reqopt",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "books", ["sku"], name: "index_books_on_sku", unique: true

  create_table "books_courses", id: false, force: true do |t|
    t.integer "book_id"
    t.integer "course_id"
  end

  create_table "courses", force: true do |t|
    t.string   "number",     null: false
    t.string   "section",    null: false
    t.string   "instructor", null: false
    t.string   "department", null: false
    t.string   "term",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "courses", ["department"], name: "index_courses_on_department"
  add_index "courses", ["instructor", "department", "number", "section", "term"], name: "by_course", unique: true
  add_index "courses", ["number"], name: "index_courses_on_number"
  add_index "courses", ["section"], name: "index_courses_on_section"

end
