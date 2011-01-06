class AddActivationToken < ActiveRecord::Migration
  def self.up
    add_column :toys, :activation_token, :string
  end

  def self.down
    remove_column :toys, :activation_token
  end
end
