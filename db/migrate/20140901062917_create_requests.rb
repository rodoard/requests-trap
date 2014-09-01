class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.hstore :body
      t.belongs_to :trap
      t.timestamps
    end
  end
end
