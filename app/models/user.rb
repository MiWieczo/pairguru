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
  has_many :comments, foreign_key: "author_id", class_name: "Comment"

  has_many :comments_this_week, -> { where("created_at > ?", 1.week.ago) },
                                foreign_key: "author_id",
                                class_name: "Comment"


  def is_allowed_to_add_comment_to_movie(movie_id)
    comments.where(movie_id: movie_id).empty?
  end

  # scope :top_ten_users, -> { where(comments_this_week == 3).limit(10) }

  # def self.top_ten_users
  #   includes(:comments_this_week).order("comments_this_week.count").limit(10)
  # end
  #
  # def self.top_ten_users
  #   includes(comments: [:created_at]).where("created_at > ?", 1.week.ago)
  # end

  def self.top
    includes(:comment).count
  end

  # scope :comments_this_week, lambda { where(comments.where("created_at > ?", 1.week.ago)) }

  # def self.top_ten_users
  #   order(comments_this_week: :desc).limit(10)
  # end
end
