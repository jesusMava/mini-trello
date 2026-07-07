# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_07_06_123632) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.bigint "workspace_id", null: false
    t.index "workspace_id, lower((name)::text)", name: "index_projects_on_workspace_id_and_lower_name", unique: true
    t.index ["workspace_id"], name: "index_projects_on_workspace_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.integer "lock_version", default: 0, null: false
    t.integer "position", default: 1, null: false
    t.bigint "project_id", null: false
    t.integer "status", default: 0, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "workspaces", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "owner_id", null: false
    t.datetime "updated_at", null: false
    t.index "owner_id, lower((name)::text)", name: "index_workspaces_on_owner_id_and_lower_name", unique: true
    t.index ["owner_id"], name: "index_workspaces_on_owner_id"
  end

  add_foreign_key "projects", "workspaces"
  add_foreign_key "tasks", "projects"
  add_foreign_key "workspaces", "users", column: "owner_id"
end
