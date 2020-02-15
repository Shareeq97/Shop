class User < ApplicationRecord
  has_secure_password
  validates :password, length: { within: 8..12 }
  validates :email, presence: true
  validates :phone_number, numericality: true, uniqueness: true, length: { minimum: 10, maximum: 15 }, allow_blank: true
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :projects
  validates_associated :projects
  
  has_many :features
  has_many :comments

  has_many :notifications, foreign_key: :recipient_id

  def to_s
  	"#{ first_name } #{ last_name }"
  end

  def username
    username = email.split('@')
    username = username[0]
  end
end


