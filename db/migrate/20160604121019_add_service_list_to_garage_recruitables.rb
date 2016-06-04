class AddServiceListToGarageRecruitables < ActiveRecord::Migration
  def change
    add_column :garage_recruitables, :service_list, :text
  end
end
