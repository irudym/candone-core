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

ActiveRecord::Schema.define(version: 2019_03_12_133112) do

  create_table "notes", force: :cascade do |t|
    t.text "markdown"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes_people", id: false, force: :cascade do |t|
    t.integer "note_id", null: false
    t.integer "person_id", null: false
    t.index ["person_id", "note_id"], name: "index_notes_people_on_person_id_and_note_id"
  end

  create_table "notes_projects", id: false, force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "note_id", null: false
    t.index ["project_id", "note_id"], name: "index_notes_projects_on_project_id_and_note_id"
  end

  create_table "notes_tasks", id: false, force: :cascade do |t|
    t.integer "note_id", null: false
    t.integer "task_id", null: false
    t.index ["note_id", "task_id"], name: "index_notes_tasks_on_note_id_and_task_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.text "description"
    t.integer "person_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_type_id"], name: "index_people_on_person_type_id"
  end

  create_table "people_projects", id: false, force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "person_id", null: false
    t.index [nil, "person_id"], name: "index_people_projects_on_note_id_and_person_id"
  end

  create_table "people_tasks", id: false, force: :cascade do |t|
    t.integer "person_id", null: false
    t.integer "task_id", null: false
    t.index ["person_id", "task_id"], name: "index_people_tasks_on_person_id_and_task_id"
  end

  create_table "person_types", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stage", default: 1
  end

  create_table "projects_tasks", id: false, force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "task_id", null: false
    t.index ["project_id", "task_id"], name: "index_projects_tasks_on_project_id_and_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "urgency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stage", default: 0
    t.datetime "completed_at"
  end

end
