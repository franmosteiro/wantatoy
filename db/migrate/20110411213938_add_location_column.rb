class AddLocationColumn < ActiveRecord::Migration
  def self.up
    add_column :toys, :location, :string
  end

  def self.down
    remove_column :toys, :location
  end
end
