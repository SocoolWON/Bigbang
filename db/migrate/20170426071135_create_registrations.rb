class CreateRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :registrations do |t|
      t.integer :count_students #학생 몇 명 찼는지
      t.integer :state  #0이면 closed, 1이면 open

      t.belongs_to :teacher
      t.belongs_to :course

      t.timestamps
    end
  end
end
