class CreateJoinTableGarageDemand < ActiveRecord::Migration
  def change
    create_join_table :garages, :demands do |t|
      t.index [:garage_id, :demand_id]
      t.index [:demand_id, :garage_id]
    end
  end
end
