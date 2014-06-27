class AddGarageRefToHoliday < ActiveRecord::Migration
  def change
    add_reference :holidays, :garage, index: true
  end
end
