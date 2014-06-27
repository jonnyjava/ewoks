class CreateJoinTableGarageProperty < ActiveRecord::Migration
  def change
    create_join_table :garages, :properties do |t|
      t.index [:garage_id, :property_id]
      t.index [:property_id, :garage_id]
    end
  end
end
