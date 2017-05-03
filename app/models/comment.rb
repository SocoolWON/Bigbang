class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :post
  belongs_to :teacher, optional: true
end
