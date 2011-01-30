class AddCancelationToken < ActiveRecord::Migration
  def self.up
    add_column :toys, :cancelation_token, :string
  end

  def self.down
    remove_column :toys, :cancelation_token
  end
end
