class AddCatToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :cat, :string
  end
end
