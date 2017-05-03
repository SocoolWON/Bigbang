class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :courses
  has_many :registrations
  has_many :posts
  has_many :comments
  has_many :reviews
  has_and_belongs_to_many :users
end
