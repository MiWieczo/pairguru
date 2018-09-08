class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :author, class_name: 'User'
  validates :text, presence: true
end
