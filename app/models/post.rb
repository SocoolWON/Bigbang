class Post < ApplicationRecord
  has_many :comments
  belongs_to :teacher
  belongs_to :course
  belongs_to :user
  belongs_to :orientation
end
