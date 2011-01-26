class RemoveRecommendedAge < ActiveRecord::Migration
  def self.up
    remove_column :toys, :recommended_age    
  end

  def self.down
    add_column :toys, :recommended_age
  end
end
