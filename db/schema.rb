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

ActiveRecord::Schema[7.1].define(version: 2024_04_13_074538) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_authors_on_name", unique: true
  end

  create_table "film_tags", force: :cascade do |t|
    t.bigint "film_id", null: false
    t.bigint "tag_id", null: false
    t.index ["film_id"], name: "index_film_tags_on_film_id"
    t.index ["tag_id"], name: "index_film_tags_on_tag_id"
  end

  create_table "films", force: :cascade do |t|
    t.string "title", null: false
    t.text "note"
    t.integer "rate", null: false
    t.integer "status", default: 0
    t.bigint "author_id", null: false
    t.index ["author_id"], name: "index_films_on_author_id"
    t.index ["title"], name: "index_films_on_title", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  add_foreign_key "film_tags", "films"
  add_foreign_key "film_tags", "tags"
  add_foreign_key "films", "authors"
end
