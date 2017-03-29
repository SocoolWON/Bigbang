class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :type #수업종류 구분
      t.datetime :started_at #수업 시작 날짜
      t.datetime :ended_at  #수업종료 날짜
      t.string :days #수업이 있는 날
      t.integer :total_classes
      t.string :course_hour #1시간 수업 or 30분
      t.string :german_time
      t.string :korean_time

      t.belongs_to :user
      t.belongs_to :teacher

      t.timestamps
    end
  end
end
