class AddGuideIdToVote < ActiveRecord::Migration
  def change
    add_column :votes, :guide_id, :integer
  end
end
