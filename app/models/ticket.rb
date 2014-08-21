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

  def count_votes(type)
    votes.where(vote_type: type).count
  end

  #compares "up" votes and "down" votes
  def score
    votes.where(vote_type: "up").count -
    votes.where(vote_type: "down").count
  end

  def voted_up?(user)
    if votes.where(user_id: user.id).where(vote_type:"up").where(ticket_id:id).count >= 1
      return true
    else
      return false
    end
  end

  def voted_down?(user)
    if votes.where(user_id: user.id).where(vote_type:"down").where(ticket_id:id).count >= 1
      return true
    else
      return false
    end
  end
end
