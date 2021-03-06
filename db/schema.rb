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

ActiveRecord::Schema.define(version: 20140610170845) do

  create_table "debts", force: true do |t|
    t.float    "amount"
    t.string   "debtor_name"
    t.string   "creditor_name"
    t.string   "debtor_phone"
    t.string   "creditor_phone"
    t.string   "message"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sent_messages", force: true do |t|
    t.text     "message"
    t.string   "to"
    t.string   "from"
    t.string   "status"
    t.integer  "debt_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sent_messages", ["debt_id"], name: "index_sent_messages_on_debt_id"

end
