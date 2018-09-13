class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :author, class_name: 'User'
  validates :text, presence: true
  validates :created_at, presence: true
end
