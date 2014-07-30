class ChangeStringToTextForPostgresql < ActiveRecord::Migration
  def change
    change_column :fees, :name, :text
    change_column :garage_properties, :value, :text
    change_column :garages, :name, :text
    change_column :garages, :street, :text
    change_column :garages, :zip, :text
    change_column :garages, :city, :text
    change_column :garages, :email, :text
    change_column :garages, :phone, :text
    change_column :garages, :mobile, :text
    change_column :garages, :fax, :text
    change_column :garages, :tax_id, :text
    change_column :garages, :website, :text
    change_column :garages, :country, :text
    change_column :garages, :logo_file_name, :text
    change_column :garages, :logo_content_type, :text
    change_column :holidays, :name, :text
    change_column :properties, :name, :text
    change_column :properties, :type_of, :text
    change_column :users, :email, :text
    change_column :users, :name, :text
    change_column :users, :surname, :text
    change_column :users, :phone, :text
    change_column :users, :country, :text
    change_column :users, :auth_token, :text
    change_column :users, :encrypted_password, :text
    change_column :users, :reset_password_token, :text
    change_column :users, :current_sign_in_ip, :text
    change_column :users, :last_sign_in_ip, :text
  end
end
