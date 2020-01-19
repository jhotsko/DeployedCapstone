class AddAttachmentImageToCadets < ActiveRecord::Migration[6.0]
  def self.up
    change_table :cadets do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :cadets, :image
  end
end
