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

ActiveRecord::Schema.define(version: 20161112220306) do

  create_table "agents", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.datetime "delivery_time"
    t.string   "company_name"
    t.integer  "contact_id"
    t.integer  "manager_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["contact_id"], name: "index_agents_on_contact_id"
    t.index ["manager_id"], name: "index_agents_on_manager_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string   "name"
    t.string   "abbr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deals", force: :cascade do |t|
    t.integer  "currency_id"
    t.string   "promo"
    t.string   "name"
    t.string   "sku"
    t.string   "unit_type"
    t.decimal  "unit_price",       precision: 10, scale: 2
    t.decimal  "promo_unit_price", precision: 10, scale: 2
    t.string   "description"
    t.string   "type"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean  "accepted",                                  default: false
    t.decimal  "probability",      precision: 4,  scale: 2
    t.index ["currency_id"], name: "index_deals_on_currency_id"
  end

  create_table "offers", force: :cascade do |t|
    t.datetime "responded_at"
    t.datetime "sent_at"
    t.integer  "agent_id"
    t.integer  "deal_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "type"
    t.index ["agent_id"], name: "index_offers_on_agent_id"
    t.index ["deal_id"], name: "index_offers_on_deal_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.string   "step"
    t.integer  "deal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_plans_on_deal_id"
  end

  create_table "values", force: :cascade do |t|
    t.decimal  "value",      precision: 12, scale: 2
    t.integer  "plan_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.datetime "set_at"
    t.boolean  "accepted"
    t.index ["plan_id"], name: "index_values_on_plan_id"
  end

  create_table "workers", force: :cascade do |t|
    t.string   "full_name"
    t.string   "position"
    t.string   "phone"
    t.string   "email"
    t.string   "skype"
    t.string   "fax"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_workers_on_email", unique: true
    t.index ["full_name"], name: "index_workers_on_full_name", unique: true
  end

end
