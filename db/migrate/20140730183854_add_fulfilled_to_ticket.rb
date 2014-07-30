class AddFulfilledToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :fulfilled, :boolean
  end
end
