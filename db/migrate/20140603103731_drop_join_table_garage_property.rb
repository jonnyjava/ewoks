class DropJoinTableGarageProperty < ActiveRecord::Migration
  def change
    drop_join_table :garages, :properties
  end
end
