class CreateGarageRecruitables < ActiveRecord::Migration
  def change
    create_table :garage_recruitables do |t|
      t.string :name
      t.string :street
      t.string :zip
      t.string :city
      t.string :email
      t.string :phone
      t.string :mobile
      t.string :tax_id
      t.string :province
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
