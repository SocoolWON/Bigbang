class CreateOrientations < ActiveRecord::Migration[5.0]
  def change
    create_table :orientations do |t|
      t.string :course_name #수업종류 구분
      t.datetime :started_at #오리엔테이션 시작 날짜
      t.string :days #수업이 있는 날
      t.string :course_hour #1시간 수업
      t.string :german_time
      t.string :korean_time

      t.belongs_to :user
      t.belongs_to :teacher

      t.timestamps
    end
  end
end
