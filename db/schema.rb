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

ActiveRecord::Schema.define(version: 20140724141537) do

  create_table "answer_choices", force: true do |t|
    t.string   "text",        null: false
    t.integer  "question_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answer_choices", ["question_id"], name: "index_answer_choices_on_question_id"
  add_index "answer_choices", ["text"], name: "index_answer_choices_on_text"

  create_table "polls", force: true do |t|
    t.string   "title",      null: false
    t.integer  "author_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "polls", ["author_id"], name: "index_polls_on_author_id"
  add_index "polls", ["title"], name: "index_polls_on_title"

  create_table "questions", force: true do |t|
    t.string   "text",       null: false
    t.integer  "poll_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["poll_id"], name: "index_questions_on_poll_id"
  add_index "questions", ["text"], name: "index_questions_on_text"

  create_table "responses", force: true do |t|
    t.integer "answer_choice_id", null: false
    t.integer "responder_id",     null: false
  end

  add_index "responses", ["answer_choice_id"], name: "index_responses_on_answer_choice_id"
  add_index "responses", ["responder_id"], name: "index_responses_on_responder_id"

  create_table "users", force: true do |t|
    t.string   "user_name",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["user_name"], name: "index_users_on_user_name", unique: true

end
