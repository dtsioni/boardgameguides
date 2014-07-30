class AddFormatToGuide < ActiveRecord::Migration
  def change
    add_column :guides, :format, :string
  end
end
