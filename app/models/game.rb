class Game < ActiveRecord::Base
  belongs_to :user
  has_many :tickets
  has_many :guides
  has_many :documents

  
  validates :name, presence: true, 
    length: {maximum: 50},
    uniqueness: {case_sensitive: false}
  validates :body, presence: true,
    length: {maximum: 126}
  validates :user_id, presence: true
end
