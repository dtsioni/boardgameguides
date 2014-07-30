class User < ActiveRecord::Base
  has_many :votes
  has_many :tickets
  has_many :games
  has_many :documents
  has_many :guides
end
