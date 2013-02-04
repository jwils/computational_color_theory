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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130204031901) do

  create_table "images", :force => true do |t|
    t.string   "image_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questions", :force => true do |t|
    t.integer  "img1_id"
    t.integer  "img2_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "questions", ["img1_id"], :name => "index_questions_on_img1_id"
  add_index "questions", ["img2_id"], :name => "index_questions_on_img2_id"

  create_table "questions_surveys", :id => false, :force => true do |t|
    t.integer "survey_id"
    t.integer "question_id"
  end

  create_table "responses", :force => true do |t|
    t.integer  "survey_id"
    t.integer  "question_id"
    t.string   "chosen_image"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "responses", ["question_id"], :name => "index_responses_on_question_id"
  add_index "responses", ["survey_id"], :name => "index_responses_on_survey_id"

  create_table "surveys", :force => true do |t|
    t.integer  "ruler_height"
    t.integer  "ruler_width"
    t.string   "ip_address"
    t.text     "comments"
    t.integer  "turkee_task_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "surveys", ["turkee_task_id"], :name => "index_surveys_on_turkee_task_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "turkee_imported_assignments", :force => true do |t|
    t.string   "assignment_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "turkee_task_id"
    t.string   "worker_id"
    t.integer  "result_id"
  end

  add_index "turkee_imported_assignments", ["assignment_id"], :name => "index_turkee_imported_assignments_on_assignment_id", :unique => true
  add_index "turkee_imported_assignments", ["turkee_task_id"], :name => "index_turkee_imported_assignments_on_turkee_task_id"

  create_table "turkee_tasks", :force => true do |t|
    t.string   "hit_url"
    t.boolean  "sandbox"
    t.string   "task_type"
    t.text     "hit_title"
    t.text     "hit_description"
    t.string   "hit_id"
    t.decimal  "hit_reward",            :precision => 10, :scale => 2
    t.integer  "hit_num_assignments"
    t.integer  "hit_lifetime"
    t.string   "form_url"
    t.integer  "completed_assignments",                                :default => 0
    t.boolean  "complete"
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.integer  "hit_duration"
    t.integer  "expired"
  end

end
