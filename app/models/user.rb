class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  has_many :votes
  has_many :tickets
  has_many :games
  has_many :documents
  has_many :guides

  has_secure_password  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {maximum: 20}
  validates :email, presence: true, 
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}
  validates :password, length: { minimum: 6 }
  validates :role, presence: true
end
