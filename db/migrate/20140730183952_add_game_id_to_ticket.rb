class AddGameIdToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :game_id, :integer
  end
end
