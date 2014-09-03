class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.json :data
      t.string :cat
      t.belongs_to :trap
      t.timestamps
    end
  end
end
