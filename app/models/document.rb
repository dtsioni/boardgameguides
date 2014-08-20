class Document < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  VALID_URL_REGEX = /\A(https?:\/\/)?([\da-zA-Z\.-]+)\.([a-zA-Z\.]{2,6})([\/\w\.-]*)*\/?\z/
  validates :name, presence: :true,
    length: {maximum: 50, minimum: 5},
    uniqueness: {case_sensitive: true}
  validates :link, presence: :true,
    uniqueness: {case_sensitive: true},
    format: {with: VALID_URL_REGEX}
  validates :format, presence: :true
  validates :user_id, presence: :true
  validates :game_id, presence: :true
end
