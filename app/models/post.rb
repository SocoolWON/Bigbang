class Post < ApplicationRecord
  has_many :comments
  belongs_to :teacher, optional: true
  belongs_to :course
  belongs_to :user, optional: true
end
