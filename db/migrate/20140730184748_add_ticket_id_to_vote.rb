class AddTicketIdToVote < ActiveRecord::Migration
  def change
    add_column :votes, :ticket_id, :integer
  end
end
