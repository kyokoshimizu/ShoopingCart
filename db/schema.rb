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

ActiveRecord::Schema.define(version: 20160615100013) do

  create_table "browsing_histories", force: true do |t|
    t.integer  "material_id"
    t.datetime "day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
  end

  create_table "card_infos", force: true do |t|
    t.integer  "self_information_id"
    t.integer  "order_id"
    t.string   "card_num"
    t.integer  "deadline"
    t.integer  "times"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deadline2"
  end

  create_table "cart_details", force: true do |t|
    t.integer  "material_id"
    t.integer  "num"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shopping_cart_id"
  end

  create_table "categories", force: true do |t|
    t.integer  "material_id"
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "materials", force: true do |t|
    t.string   "title"
    t.integer  "price"
    t.integer  "size"
    t.string   "detail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

  create_table "orders", force: true do |t|
    t.integer  "shopping_cart_id"
    t.string   "name"
    t.string   "address"
    t.integer  "payment_method"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "decide_order",     default: false, null: false
    t.integer  "member_id"
    t.string   "postal"
  end

  create_table "photos", force: true do |t|
    t.integer  "material_id"
    t.binary   "photo",              limit: 16777215
    t.string   "photo_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "self_informations", force: true do |t|
    t.integer  "member_id"
    t.string   "name"
    t.string   "address"
    t.string   "payment_method"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "postal"
  end

  create_table "shopping_carts", force: true do |t|
    t.datetime "oder_day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
  end

end
