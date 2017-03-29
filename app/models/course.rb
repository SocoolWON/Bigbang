class Course < ApplicationRecord
  belongs_to :user
  belongs_to :teacher
  has_many :posts
  has_many :reviews
end
