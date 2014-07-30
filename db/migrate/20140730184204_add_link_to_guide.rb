class AddLinkToGuide < ActiveRecord::Migration
  def change
    add_column :guides, :link, :string
  end
end
