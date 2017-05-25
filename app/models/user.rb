class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :comments
  has_many :reviews
  has_many :registrations
  has_many :registered_courses, through: :registrations, source: :course
  has_many :courses, through: :registrations
  has_and_belongs_to_many :teachers

  def is_registered?(registration)
     Registration.find_by(user_id: self.id, course_id: registration.course_id).present?
  end
end
