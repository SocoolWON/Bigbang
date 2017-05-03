class CreateJoinTableTeachersUsers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :teachers, :users do |t|
      # t.index [:teacher_id, :user_id]
      # t.index [:user_id, :teacher_id]
    end
  end
end
