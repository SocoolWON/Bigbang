class CreateRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :registrations do |t|
      t.string :state 
      t.string :studentNumberInCourse
      t.datetime :fee_deadline

      t.belongs_to :teacher
      t.belongs_to :course
      t.belongs_to :user

      t.timestamps
    end
  end
end
