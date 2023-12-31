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

ActiveRecord::Schema[7.0].define(version: 2023_09_15_234242) do
  create_table "transaction_groups", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "transaction_group_id", null: false
    t.float "amount", null: false
    t.string "transaction_type", null: false
    t.bigint "source_user_id_id"
    t.bigint "target_user_id_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_user_id_id"], name: "index_transactions_on_source_user_id_id"
    t.index ["target_user_id_id"], name: "index_transactions_on_target_user_id_id"
    t.index ["transaction_group_id"], name: "index_transactions_on_transaction_group_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "account_no", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "transactions", "transaction_groups"
  add_foreign_key "transactions", "users"
  add_foreign_key "transactions", "users", column: "source_user_id_id"
  add_foreign_key "transactions", "users", column: "target_user_id_id"
end
