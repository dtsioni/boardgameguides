class AddBodyToGame < ActiveRecord::Migration
  def change
    add_column :games, :body, :string
  end
end
