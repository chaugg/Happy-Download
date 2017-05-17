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

ActiveRecord::Schema.define(version: 20170518032905) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.text     "content"
    t.integer  "star"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "notifier_id"
    t.integer  "notifiee_id"
    t.integer  "product_id"
    t.string   "notify_type"
    t.boolean  "isread"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["notifiee_id"], name: "index_notifications_on_notifiee_id"
    t.index ["notifier_id"], name: "index_notifications_on_notifier_id"
    t.index ["product_id"], name: "index_notifications_on_product_id"
  end

  create_table "order_details", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "status"
    t.text     "note"
    t.decimal  "total_price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "link_preview"
    t.text     "title"
    t.text     "summary"
    t.text     "content"
    t.decimal  "price"
    t.string   "image_product"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "image_product_file_name"
    t.string   "image_product_content_type"
    t.integer  "image_product_file_size"
    t.datetime "image_product_updated_at"
    t.string   "item_file_name"
    t.string   "item_content_type"
    t.integer  "item_file_size"
    t.datetime "item_updated_at"
    t.index ["user_id", "created_at"], name: "index_products_on_user_id_and_created_at"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "full_name"
    t.string   "address"
    t.string   "phone_number"
    t.integer  "age"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.boolean  "admin"
    t.string   "email_address"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wish_lists", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
