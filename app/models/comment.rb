class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :author, class_name: 'User'
  validates :text, presence: true

  def self.top_users(how_many, since_when)
    includes(author: [:id]).where("created_at > ?", since_when).group(:author).count.sort_by {|user, number| number}.reverse.take(how_many)
  end

end
