class AddlatLngColumns < ActiveRecord::Migration
  def self.up
    add_column :toys, :lat, :string
    add_column :toys, :lng, :string
  end

  def self.down
    remove_column :toys, :lat
    remove_column :toys, :lng
  end
end
