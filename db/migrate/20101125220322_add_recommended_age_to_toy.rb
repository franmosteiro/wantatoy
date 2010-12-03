class AddRecommendedAgeToToy < ActiveRecord::Migration
  def self.up
    add_column :toys, :recommended_age, :integer
  end

  def self.down
    remove_column :toys, :recommended_age
  end
end
