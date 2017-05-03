class CreateJoinTableRegistrationsUsers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :registrations, :users do |t|
      # t.index [:registration_id, :user_id]
      # t.index [:user_id, :registration_id]
    end
  end
end
