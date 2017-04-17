class Orientation < ApplicationRecord
  belongs_to :user
  belongs_to :teacher
  has_many :posts
end
