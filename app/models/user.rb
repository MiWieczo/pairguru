# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :phone_number, format: { with: /\A[+]?\d+(?>[- .]\d+)*\z/, allow_nil: true }
  validates :email, presence: true, uniqueness: true
  validates :name, :password, presence: true

  has_many :comments, foreign_key: "author_id", class_name: "Comment"

  has_many :comments_this_week, -> { where("created_at > ?", 1.week.ago) },
           foreign_key: "author_id",
           class_name: "Comment"

  def allowed_to_add_comment_to_movie?(movie_id)
    comments.where(movie_id: movie_id).empty?
  end

  def number_of_comments_this_week
    comments_this_week.count
  end
end
