class CreateJoinTableGarageService < ActiveRecord::Migration
  def change
    create_join_table :garages, :services do |t|
      t.index [:garage_id, :service_id]
      t.index [:service_id, :garage_id]
    end
  end
end
