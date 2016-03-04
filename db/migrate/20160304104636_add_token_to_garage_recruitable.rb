class AddTokenToGarageRecruitable < ActiveRecord::Migration
  def change
    add_column :garage_recruitables, :token, :string
  end
end
