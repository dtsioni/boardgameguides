class AddGameIdToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :game_id, :integer
  end
end
