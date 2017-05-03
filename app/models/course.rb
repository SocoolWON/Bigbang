class Course < ApplicationRecord
  has_one :registration
  has_and_belongs_to_many :users
  belongs_to :teacher
  has_many :posts
  has_many :reviews

  validates :category, 
    inclusion: { in: %w(Offline  Online), message: "%{value} must be one of online and offline" },
    presence: true
  validates :location,
    presence: { :if => lambda {self.category == "Offline"}, message: "Must select one location" }
  validates :course_type,
    inclusion: { in: ['Beginner', 'Intermediate', 'Advanced', 'Current Affairs', 'Test A1', 'Test A2', 'Test B1', 'Test B2', 'German Culture', 'Free Topic'], message: "Must select one course type" },
    presence: true
  validates :started_at,
    format: { with: /\A[2]{1}[0-9]{3}-[0-1]{1}[0-9]{1}-[0-3]{1}[0-9]{1}/, message: "only allows numbers" },
    presence: true
  validates :days,
    # inclusion: { in: ['Mon' 'Tue' 'Wed' 'Thu' 'Fri' 'Sat' 'Sun' ""], message: "%{value} should be one day of a week" },
    presence: true
  validates :german_time,
    format: { with: /\A[0-2]{1}[0-9]{1}:[0-3]{1}[0]{1}/, message: "must be in time format(hh:mm)"},
    presence: true
  validates :introduction,
    length: { maximum: 500, message: "cannot be over 500 words" },
    presence: true
 
end
