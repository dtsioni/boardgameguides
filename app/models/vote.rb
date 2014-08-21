class Vote < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  belongs_to :guide
  #unique per ticket id and vote type
  validates_uniqueness_of :user_id, scope: [:ticket_id, :vote_type]
end
