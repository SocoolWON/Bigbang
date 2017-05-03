class CreateRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :registrations do |t|
      t.string :category #수업종류 구분 offline / online
      t.string :course_type #세부 구분
      t.string :introduction #수업 설명
      t.integer :count_students #학생 몇 명 찼는지
      t.datetime :started_at #수업 시작 날짜
      t.datetime :ended_at  #수업종료 날짜
      t.string :location  #오프라인 수업 장소
      t.string :days #수업이 있는 날
      t.integer :total_classes #총 수업횟수
      t.string :course_hour #1시간 수업
      t.string :german_time
      t.string :korean_time

      t.belongs_to :teacher
      t.belongs_to :course

      t.timestamps
    end
  end
end
