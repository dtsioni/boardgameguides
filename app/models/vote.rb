class Vote < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  belongs_to :guide
end
