class AddGameIdToGuide < ActiveRecord::Migration
  def change
    add_column :guides, :game_id, :integer
  end
end
