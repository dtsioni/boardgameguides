class AddBodyToGuide < ActiveRecord::Migration
  def change
    add_column :guides, :body, :text
  end
end
