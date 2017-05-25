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

ActiveRecord::Schema.define(version: 20170426141840) do

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "post_id"
    t.integer  "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["teacher_id"], name: "index_comments_on_teacher_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "category"
    t.string   "course_type"
    t.string   "introduction"
    t.integer  "registrations_count"
    t.date     "started_at"
    t.date     "ended_at"
    t.string   "location"
    t.string   "days"
    t.integer  "total_classes"
    t.string   "course_hour"
    t.string   "german_time"
    t.string   "korean_time"
    t.integer  "state"
    t.string   "studentNumberInCourse"
    t.text     "room_session"
    t.text     "room_session_id"
    t.integer  "teacher_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_posts_on_course_id"
    t.index ["teacher_id"], name: "index_posts_on_teacher_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "registrations", force: :cascade do |t|
    t.string   "state"
    t.string   "studentNumberInCourse"
    t.datetime "fee_deadline"
    t.integer  "teacher_id"
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["course_id"], name: "index_registrations_on_course_id"
    t.index ["teacher_id"], name: "index_registrations_on_teacher_id"
    t.index ["user_id"], name: "index_registrations_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "fun"
    t.integer  "communication"
    t.integer  "useful"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "teacher_id"
    t.integer  "course_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["course_id"], name: "index_reviews_on_course_id"
    t.index ["teacher_id"], name: "index_reviews_on_teacher_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "hours"
    t.string   "days"
    t.integer  "salary"
    t.integer  "hourly_wage"
    t.integer  "phone_number"
    t.string   "education"
    t.string   "deduction"
    t.string   "work"
    t.string   "interest"
    t.text     "introduction"
    t.string   "paypal"
    t.integer  "level"
    t.string   "status"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_teachers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true
  end

  create_table "teachers_users", id: false, force: :cascade do |t|
    t.integer "teacher_id", null: false
    t.integer "user_id",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "phone_number"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
