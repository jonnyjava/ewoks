class AddAttachmentLogoToGarages < ActiveRecord::Migration
  def self.up
    change_table :garages do |t|
      t.attachment :logo
    end
  end

  def self.down
    drop_attached_file :garages, :logo
  end
end
