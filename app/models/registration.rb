class Registration < ApplicationRecord
  belongs_to :teacher
  belongs_to :course
  has_and_belongs_to_many :users
end
