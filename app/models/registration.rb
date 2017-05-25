class Registration < ApplicationRecord
  belongs_to :teacher 
  belongs_to :course, counter_cache: true
  belongs_to :user, optional: true
end
