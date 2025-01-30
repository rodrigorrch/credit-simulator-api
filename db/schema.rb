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

ActiveRecord::Schema[8.0].define(version: 2025_01_30_024906) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "loan_simulations", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.date "birth_date", null: false
    t.integer "installments", null: false
    t.decimal "interest_rate", precision: 5, scale: 4, null: false
    t.string "rate_type", default: "fixed", null: false
    t.string "currency", default: "BRL", null: false
    t.decimal "monthly_payment", precision: 10, scale: 2
    t.decimal "total_amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "notification_email"
    t.decimal "spread", precision: 10, scale: 2
  end
end
