# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_20_233224) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "user_id"
    t.integer "attempt"
    t.string "result"
    t.string "user_guess"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_feedbacks_on_game_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "attempts_remaining", default: 10
    t.string "number_combo"
    t.boolean "won", default: false
    t.integer "difficulty"
    t.integer "score"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "feedbacks_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
