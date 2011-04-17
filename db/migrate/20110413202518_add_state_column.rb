class AddStateColumn < ActiveRecord::Migration
  def self.up
    add_column :toys, :state, :string
  end

  def self.down
    remove_column :toys, :state
  end
end
