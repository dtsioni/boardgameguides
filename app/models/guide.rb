class Guide < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :votes
  VALID_URL_REGEX = /\A(https?:\/\/)?([\da-zA-Z\.-]+)\.([a-zA-Z\.]{2,6})([\/\w\.-]*)*\/?\z/
  
  validates :name, presence: true,
    length:{minimum: 5, maximum: 100}
  validates :format, presence: true
  validates :link, format: {with: VALID_URL_REGEX},
    allow_blank: true
  validates :user_id, presence: true
  validates :game_id, presence: true

end
