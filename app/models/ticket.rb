class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :votes

  validates :name, presence: true,
    length: {maximum: 121}
  validates :body, presence: true,
    length: {maximum: 90, minimum: 18}
  validates :fulfilled, :inclusion => { :in => [true, false] }
  validates :status, presence: :true,
    length: {maximum: 50, minimum: 3}

end
