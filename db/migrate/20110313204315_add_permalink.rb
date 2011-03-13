class AddPermalink < ActiveRecord::Migration
  def self.up
    add_column :toys, :permalink, :string
  end

  def self.down
    remove_column :toys, :permalink
  end  
end
