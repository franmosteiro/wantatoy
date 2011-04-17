class FloatLatLngColumns < ActiveRecord::Migration
  def self.up
    remove_column :toys, :lat
    remove_column :toys, :lng
    add_column :toys, :lat, :float
    add_column :toys, :lng, :float
  end

  def self.down
    remove_column :toys, :lat
    remove_column :toys, :lng    
    add_column :toys, :lat, :string
    add_column :toys, :lng, :string    
  end
end
