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

  validates :firstname, 
      format: { with: /\A[a-zA-Z]+\z/,
        message: "First name은 오직 알파벳만 가능합니다" },
      presence: true
  validates :lastname, 
      format: { with: /\A[a-zA-Z]+\z/,
        message: "Last name은 오직 알파벳만 가능합니다" },
      presence: true

  def is_registered?(registration)
     Registration.find_by(user_id: self.id, course_id: registration.course_id).present?
  end
end
