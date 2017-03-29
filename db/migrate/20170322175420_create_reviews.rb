class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :fun
      t.integer :communication
      t.integer :accuracy 
      t.integer :value
      t.integer :useful
      t.text :content

      t.belongs_to :user
      t.belongs_to :teacher
      t.belongs_to :course

      t.timestamps
    end
  end
end
