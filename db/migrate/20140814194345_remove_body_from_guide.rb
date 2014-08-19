class RemoveBodyFromGuide < ActiveRecord::Migration
  def change
    remove_column :guides, :body, :string
  end
end
