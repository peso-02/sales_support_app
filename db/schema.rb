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

ActiveRecord::Schema[7.1].define(version: 2026_02_23_082500) do
  create_table "customers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "customer_code"
    t.string "customer_name"
    t.integer "closing_day"
    t.integer "payment_terms"
    t.string "business_type"
    t.boolean "case_break_shipping_allowed"
    t.integer "case_break_shipping_fee"
    t.integer "delivery_note_type"
    t.integer "order_method"
    t.integer "sales_rep_id"
    t.integer "assistant_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manual_update_requests", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "manual_id", null: false
    t.integer "requested_by_id"
    t.integer "status"
    t.text "request_note"
    t.text "response_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manual_id"], name: "index_manual_update_requests_on_manual_id"
  end

  create_table "manuals", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "title"
    t.integer "file_status"
    t.integer "approved_by_id"
    t.datetime "approved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_manuals_on_customer_id"
  end

  create_table "product_prices", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "product_id", null: false
    t.decimal "selling_price", precision: 10
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_product_prices_on_customer_id"
    t.index ["product_id"], name: "index_product_prices_on_product_id"
  end

  create_table "products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "product_code"
    t.string "product_name"
    t.integer "case_quantity"
    t.decimal "standard_price_a", precision: 10
    t.decimal "standard_price_b", precision: 10
    t.decimal "standard_price_c", precision: 10
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supplier_contacts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "supplier_id", null: false
    t.string "contact_name"
    t.string "email"
    t.string "phone"
    t.string "fax"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_supplier_contacts_on_supplier_id"
  end

  create_table "suppliers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "supplier_code"
    t.string "supplier_name"
    t.integer "closing_day"
    t.integer "payment_terms"
    t.boolean "case_break_order_allowed"
    t.integer "case_break_order_fee"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "manual_update_requests", "manuals"
  add_foreign_key "manuals", "customers"
  add_foreign_key "product_prices", "customers"
  add_foreign_key "product_prices", "products"
  add_foreign_key "supplier_contacts", "suppliers"
end
