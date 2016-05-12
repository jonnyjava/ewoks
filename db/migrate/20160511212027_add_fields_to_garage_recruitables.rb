class AddFieldsToGarageRecruitables < ActiveRecord::Migration
  def change
    add_column :garage_recruitables, :scrapped_id, :string
    add_column :garage_recruitables, :scrapped_type, :string
    add_column :garage_recruitables, :address, :string
    add_column :garage_recruitables, :fax, :string
    add_column :garage_recruitables, :fees, :string
    add_column :garage_recruitables, :owner, :string
    add_column :garage_recruitables, :timetable, :string
    add_column :garage_recruitables, :website, :string
    add_column :garage_recruitables, :zipcode_with_city, :string
  end
end
