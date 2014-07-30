class AddBodyToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :body, :string
  end
end
