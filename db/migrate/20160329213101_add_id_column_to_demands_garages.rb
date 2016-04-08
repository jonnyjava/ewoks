class AddIdColumnToDemandsGarages < ActiveRecord::Migration
  def change
    add_column :demands_garages, :id, :primary_key
  end
end
