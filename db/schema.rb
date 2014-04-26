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

ActiveRecord::Schema.define(version: 20140426061543) do

  create_table "comments", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "limits", force: true do |t|
    t.integer  "time",       default: 1000
    t.integer  "memory",     default: 65536
    t.integer  "output",     default: 65536
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "problem_id"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "problem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "problems", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "input"
    t.text     "output"
    t.text     "example_input"
    t.text     "example_output"
    t.text     "hint"
  end

  create_table "submissions", force: true do |t|
    t.text     "code"
    t.string   "compiler"
    t.string   "result"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "problem_id"
    t.integer  "user_id"
  end

  create_table "testdata", force: true do |t|
    t.text     "input"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "problem_id"
  end

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
    t.string   "avatar_url"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
