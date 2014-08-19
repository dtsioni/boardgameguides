class Guide < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :votes

  validates :name, presence: true,
    length:{minimum: 5, maximum: 100}
  validates :format, presence: true
  validates :user_id, presence: true
  validates :game_id, presence: true

end
