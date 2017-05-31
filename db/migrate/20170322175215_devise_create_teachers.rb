class DeviseCreateTeachers < ActiveRecord::Migration[5.0]
  def change
    create_table :teachers do |t|
      t.string :firstname
      t.string :lastname
      t.integer :salary
      t.integer :hourly_wage
      t.integer :phone_number #should be connected with WhatsApp
      t.string :univ #University or deploma 
      t.string :major
      t.string :deduction #minus
      t.string :interest
      t.string :paypal
      t.integer :level  #Level 1 for offline tutor, Level 2 for offline tutor, Level 3 For all and level 4 is Assistant
      t.string :status
      t.string :picture 
      t.text :introduction 
      
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :teachers, :email,                unique: true
    add_index :teachers, :reset_password_token, unique: true
    # add_index :teachers, :confirmation_token,   unique: true
    # add_index :teachers, :unlock_token,         unique: true
  end
end
