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

ActiveRecord::Schema.define(version: 20151226144928) do

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.text     "text"
    t.string   "marks_integer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"
  add_index "answers", ["user_id"], name: "index_answers_on_user_id"

  create_table "answers_interventions", id: false, force: :cascade do |t|
    t.integer "intervention_id"
    t.integer "answer_id"
  end

  create_table "arcticles", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attempted_questions", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "answer_id"
    t.integer  "question_id"
    t.integer  "objective_id"
    t.integer  "topic_id"
    t.integer  "subject_id"
  end

  create_table "attempts", force: :cascade do |t|
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "keypoint_id"
    t.integer  "user_id"
  end

  create_table "common_errors", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flashcards", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "objective_id"
    t.text     "text"
    t.text     "top"
    t.text     "bottom"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "improvement_id"
  end

  create_table "improvements", force: :cascade do |t|
    t.text     "area_to_improve"
    t.boolean  "checked"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subject_id"
    t.integer  "topic_id"
    t.integer  "flashcard_id"
  end

  add_index "improvements", ["user_id"], name: "index_improvements_on_user_id"

  create_table "interventions", force: :cascade do |t|
    t.text     "problem"
    t.text     "fix"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keypoints", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "flashcard_id"
    t.text     "text"
  end

  create_table "lessons", force: :cascade do |t|
    t.date     "date"
    t.integer  "subject_id"
    t.string   "title"
    t.text     "powerpoint"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lessons", ["subject_id"], name: "index_lessons_on_subject_id"

  create_table "lines", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "objective_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lines", ["objective_id"], name: "index_lines_on_objective_id"
  add_index "lines", ["question_id"], name: "index_lines_on_question_id"

  create_table "main_questions", force: :cascade do |t|
    t.text     "answer_html"
    t.string   "exampro_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "main_questions"
    t.integer  "test_paper_id"
    t.text     "html"
  end

  create_table "main_questions_objectives", id: false, force: :cascade do |t|
    t.integer "question_id"
    t.integer "objective_id"
    t.integer "main_question_id"
  end

  add_index "main_questions_objectives", ["objective_id"], name: "index_main_questions_objectives_on_objective_id"
  add_index "main_questions_objectives", ["question_id"], name: "index_main_questions_objectives_on_question_id"

  create_table "main_questions_test_papers", id: false, force: :cascade do |t|
    t.integer "main_question_id"
    t.integer "test_paper_id"
  end

  add_index "main_questions_test_papers", ["main_question_id"], name: "index_main_questions_test_papers_on_main_question_id"
  add_index "main_questions_test_papers", ["test_paper_id"], name: "index_main_questions_test_papers_on_test_paper_id"

  create_table "objective_states", force: :cascade do |t|
    t.string   "status"
    t.integer  "user_id"
    t.integer  "objective_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "objective_states", ["objective_id"], name: "index_objective_states_on_objective_id"
  add_index "objective_states", ["user_id"], name: "index_objective_states_on_user_id"

  create_table "objectives", force: :cascade do |t|
    t.text     "name"
    t.text     "module_pack_info"
    t.integer  "total_marks"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topic_id"
    t.integer  "easier_difficulty"
    t.integer  "harder_difficulty"
    t.integer  "main_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "topic_id"
    t.text     "text"
    t.integer  "total_marks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "test_paper_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.text     "html"
    t.text     "mark_scheme_html"
    t.text     "exam_notes_html"
    t.text     "source"
    t.text     "description"
    t.text     "type"
    t.text     "intervention"
    t.string   "position"
    t.integer  "main_question_id"
  end

  add_index "questions", ["topic_id"], name: "index_questions_on_topic_id"

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "improvement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["improvement_id"], name: "index_reviews_on_improvement_id"
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "set_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "year"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "set_groups", ["subject_id"], name: "index_set_groups_on_subject_id"

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "test_papers", force: :cascade do |t|
    t.integer  "subject_id"
    t.date     "date"
    t.boolean  "calc_allowed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "test_papers"
    t.boolean  "important"
  end

  add_index "test_papers", ["subject_id"], name: "index_test_papers_on_subject_id"

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["subject_id"], name: "index_topics_on_subject_id"

  create_table "units", force: :cascade do |t|
    t.string   "name"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "units", ["subject_id"], name: "index_units_on_subject_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "power"
    t.string   "grade"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
